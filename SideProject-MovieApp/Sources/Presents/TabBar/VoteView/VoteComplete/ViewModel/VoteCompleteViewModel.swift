//
//  VoteCompleteViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/05.
//

import Foundation
import RxSwift
import RxCocoa

final class VoteCompleteViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteCoordinator?
    private var voteUseCase: VoteUseCase
    private let characterInfo: BehaviorRelay<CharacterInfo>
//    private let voteCharacter: BehaviorRelay<VoteCharacter>

    init(coordinator: VoteCoordinator?, voteUseCase: VoteUseCase, characterInfo: CharacterInfo) {
        self.coordinator = coordinator
        self.voteUseCase = voteUseCase
        self.characterInfo = BehaviorRelay(value: characterInfo)
//        self.voteCharacter = BehaviorRelay(value: voteCharacter)
    }
    
    struct Input{
        let viewDidLoad: PublishRelay<Void>
        let rightNavigationXButtonTapped: PublishRelay<Void>
    }
    
    struct Output{
        let sameWorkAnotherCharacterList: PublishRelay<SameWorkCharacterList>
        let characterInfo: BehaviorRelay<CharacterInfo>
//        let voteCharacter: BehaviorRelay<VoteCharacter>
        let inquireVoteResult: PublishRelay<InquireVoteResult>
    }
    
    let sameWorkAnotherCharacterList =  PublishRelay<SameWorkCharacterList>()
    let inquireVoteResult = PublishRelay<InquireVoteResult>()
    
    func transform(input: Input) -> Output {

        input.viewDidLoad
            .withLatestFrom(self.characterInfo)
            .bind { [weak self] characterInfo in
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                self.getSameWorkAnotherChacracter(user_id: user_id, character_id: characterInfo.character_id)
                self.getInquireVoteResult(user_id: user_id, character_id: characterInfo.character_id)
            }
            .disposed(by: disposeBag)
        
        input.rightNavigationXButtonTapped
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.start()
            }
            .disposed(by: disposeBag)
        
        return Output(sameWorkAnotherCharacterList: self.sameWorkAnotherCharacterList, characterInfo: self.characterInfo, inquireVoteResult: self.inquireVoteResult)
    }
}

extension VoteCompleteViewModel {
    private func getSameWorkAnotherChacracter(user_id: String, character_id: Int) {
        Task {
            let sameWorkAnotherCharacter = try await voteUseCase.excuteSameWorkCharacterList(query: SameWorkCharacterListQuery(user_id: user_id, character_id: character_id))
            print("같은 작품 내 캐릭터 조회 완료", sameWorkAnotherCharacter)
            self.sameWorkAnotherCharacterList.accept(sameWorkAnotherCharacter)
        }
    }
}

extension VoteCompleteViewModel {
    private func getInquireVoteResult(user_id: String, character_id: Int) {
        Task {
            let inquireVoteResult = try await voteUseCase.excuteInquireVoteResult(query: InquireVoteResultQuery(user_id: user_id, character_id: character_id))
            print("투표 결과 확인", inquireVoteResult)
            self.inquireVoteResult.accept(inquireVoteResult)
        }
    }
}
