//
//  MyCharacterMoreViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import Foundation
import RxSwift
import RxCocoa

final class MyCharacterMoreViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: MyMomentumCoordinator?
    
    struct Input{
        let myDigCharacterCellSelected: PublishRelay<MyVotedCharacter>

    }
    
    struct Output{
        let characters: BehaviorRelay<[MyVotedCharacter?]>
    }
    
    init(coordinator: MyMomentumCoordinator? = nil, characters: [MyVotedCharacter?]) {
        self.coordinator = coordinator
        self.characters = BehaviorRelay(value: characters)
    }
    
    var characters: BehaviorRelay<[MyVotedCharacter?]> = BehaviorRelay(value: [])
    
    func transform(input: Input) -> Output {
        
        input.myDigCharacterCellSelected
            .withUnretained(self)
            .bind { vm, character in
                vm.coordinator?.showTabmanCharacterCoordinator(character: Characters(character_id: character.character_id, character_name: character.character_name, character_img: character.character_img, character_mbti: character.character_mbti))
            }
            .disposed(by: disposeBag)
        
        return Output(characters: self.characters)
    }
}
