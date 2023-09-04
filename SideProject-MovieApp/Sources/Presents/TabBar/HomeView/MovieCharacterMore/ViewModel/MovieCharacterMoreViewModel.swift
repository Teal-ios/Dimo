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
    private weak var coordinator: HomeCoordinator?
    
    struct Input{


    }
    
    struct Output{
        let characters: BehaviorRelay<[Characters?]>
    }
    
    init(coordinator: HomeCoordinator, characters: [Characters?]) {
        self.coordinator = coordinator
        self.characters = BehaviorRelay(value: characters)
    }
    
    var characters: BehaviorRelay<[Characters?]> = BehaviorRelay(value: [])
    
    func transform(input: Input) -> Output {

        return Output(characters: self.characters)
    }
}
