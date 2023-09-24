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

        return Output(characters: self.characters)
    }
}
