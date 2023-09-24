//
//  CharacterMoreViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/23.
//

import Foundation
import RxSwift
import RxCocoa

final class CharacterMoreViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: CharacterMoreCoordinator?
    
    struct Input{
        let characterCellSelected: PublishRelay<SameMbtiCharacter>

    }
    
    struct Output{
        let characters: BehaviorRelay<[SameMbtiCharacter]>
    }
    
    init(coordinator: CharacterMoreCoordinator? = nil, characters: [SameMbtiCharacter]) {
        self.coordinator = coordinator
        self.characters = BehaviorRelay(value: characters)
    }
    
    let characters: BehaviorRelay<[SameMbtiCharacter]>
    
    func transform(input: Input) -> Output {

        input.characterCellSelected
            .withUnretained(self)
            .bind { vm, character in
                vm.coordinator?.showTabmanCharacterCoordinator(character: Characters(character_id: character.character_id, character_name: character.character_name, character_img: character.character_img, character_mbti: character.character_mbti))
            }
            .disposed(by: disposeBag)
        
        return Output(characters: self.characters)
    }
}
