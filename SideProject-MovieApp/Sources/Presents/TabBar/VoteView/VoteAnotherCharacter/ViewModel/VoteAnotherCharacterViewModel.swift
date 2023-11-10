//
//  VoteAnotherCharacterViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/10.
//

import Foundation
import RxSwift
import RxCocoa

final class VoteAnotherCharacterViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteFlowCoordinator?
    
    struct Input{


    }
    
    struct Output{
        let characters: BehaviorRelay<[Result?]>
    }
    
    init(coordinator: VoteFlowCoordinator, characters: [Result?]) {
        self.coordinator = coordinator
        self.characters = BehaviorRelay(value: characters)
    }
    
    var characters: BehaviorRelay<[Result?]> = BehaviorRelay(value: [])
    
    func transform(input: Input) -> Output {

        return Output(characters: self.characters)
    }
}
