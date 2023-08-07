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

    init(coordinator: VoteCoordinator?, voteUseCase: VoteUseCase, characterInfo: CharacterInfo) {
        self.coordinator = coordinator
        self.voteUseCase = voteUseCase
        self.characterInfo = BehaviorRelay(value: characterInfo)
    }
    
    struct Input{
        let viewDidLoad: PublishRelay<Void>
    }
    
    struct Output{
        let sameWorkAnotherCharacterList: PublishRelay<SameWorkCharacterList>
        let characterInfo: BehaviorRelay<CharacterInfo>
    }
    
    let sameWorkAnotherCharacterList =  PublishRelay<SameWorkCharacterList>()
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoad
            .withUnretained(self)
            .bind { vm, _ in
                guard let user_id = UserDefaultManager.userId else { return }
                vm.getSameWorkAnotherChacracter(user_id: user_id, search_content: "히타치")
            }
            .disposed(by: disposeBag)

        
        return Output(sameWorkAnotherCharacterList: self.sameWorkAnotherCharacterList, characterInfo: self.characterInfo)
    }
}

extension VoteCompleteViewModel {
    private func getSameWorkAnotherChacracter(user_id: String, search_content: String) {
        Task {
            let sameWorkAnotherCharacter = try await voteUseCase.excuteSameWorkCharacterList(query: SameWorkCharacterListQuery(user_id: user_id, search_content: search_content))
            print("같은 작품 내 캐릭터 조회 완료", sameWorkAnotherCharacter)
            self.sameWorkAnotherCharacterList.accept(sameWorkAnotherCharacter)
        }
    }
}
