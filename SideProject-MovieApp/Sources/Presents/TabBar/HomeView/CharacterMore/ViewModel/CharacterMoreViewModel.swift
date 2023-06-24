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
    private weak var coordinator: HomeCoordinator?
    
    struct Input{


    }
    
    struct Output{
    }
    
    init(coordinator: HomeCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {

        return Output()
    }
}
