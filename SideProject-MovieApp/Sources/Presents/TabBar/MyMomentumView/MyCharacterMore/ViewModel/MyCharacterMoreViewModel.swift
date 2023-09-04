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

        return Output(characters: self.characters)
    }
}
