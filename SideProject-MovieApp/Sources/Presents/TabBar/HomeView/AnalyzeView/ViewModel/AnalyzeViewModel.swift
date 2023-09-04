//
//  AnalyzeViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/06.
//

import Foundation
import RxSwift
import RxCocoa

final class AnalyzeViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private var voteUseCase: VoteUseCase
    var characterId: BehaviorRelay<Int?>
    
    init(coordinator: TabmanCoordinator? = nil, voteUseCase: VoteUseCase, characterId: Int?) {
        self.coordinator = coordinator
        self.voteUseCase = voteUseCase
        self.characterId = BehaviorRelay(value: characterId)
    }
    
    struct Input{
        let viewDidLoad: PublishRelay<Void>
        let revoteButtonTapped: ControlEvent<Void>
        let voteButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let inquireCharacterAnalyze: PublishRelay<InquireCharacterAnalyze>
    }
    
    let inquireCharacterAnalyze = PublishRelay<InquireCharacterAnalyze>()
    
    func transform(input: Input) -> Output {
        
        Observable.zip(input.viewDidLoad, self.characterId)
            .bind { [weak self] _, characterId in
                guard let self = self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                guard let characterId = characterId else { return }
                print("viewdidload")
                self.getInquireCharacterAnalyze(user_id: user_id, character_id: characterId)
            }
            .disposed(by: disposeBag)
        
        return Output(inquireCharacterAnalyze: self.inquireCharacterAnalyze)
    }
}

extension AnalyzeViewModel {
    private func getInquireCharacterAnalyze(user_id: String, character_id: Int) {
        Task {
            let inquireCharacterAnalyze = try await voteUseCase.excuteInquireCharacterAnalyze(query: InquireCharacterAnalyzeQuery(user_id: user_id, character_id: character_id))
            print("캐릭터 분석결과",  inquireCharacterAnalyze)
            self.inquireCharacterAnalyze.accept(inquireCharacterAnalyze)
        }
    }
}
