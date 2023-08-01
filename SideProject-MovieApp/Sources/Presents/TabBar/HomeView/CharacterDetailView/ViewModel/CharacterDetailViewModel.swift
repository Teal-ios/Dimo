//
//  CharacterDetailViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import Foundation
import RxSwift
import RxCocoa

final class CharacterDetailViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    weak var coordinator: TabmanCoordinator?
    
    struct Input{


    }
    
    struct Output{
        let character: BehaviorRelay<Characters?>

    }
    
    init(coordinator: TabmanCoordinator? = nil, character: Characters?) {
        self.coordinator = coordinator
        self.character = BehaviorRelay<Characters?>(value: character)
    }
    
    var character = BehaviorRelay<Characters?>(value: nil)

    func transform(input: Input) -> Output {

        return Output(character: self.character)
    }
}
