//
//  MovieCharacterMoreViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieCharacterMoreViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: MovieDetailCoordinator?
    
    struct Input{
        let cardCellSelected: PublishRelay<Characters>
    }
    
    struct Output{
        let characters: BehaviorRelay<[Characters?]>
    }
    
    init(coordinator: MovieDetailCoordinator, characters: [Characters?]) {
        self.coordinator = coordinator
        self.characters = BehaviorRelay(value: characters)
    }
    
    var characters: BehaviorRelay<[Characters?]> = BehaviorRelay(value: [])
    
    func transform(input: Input) -> Output {

        input.cardCellSelected
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { owner, character in
                owner.coordinator?.showTabmanCoordinator(character: character)
            }
            .disposed(by: disposeBag)
        return Output(characters: self.characters)
    }
}
