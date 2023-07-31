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
    }
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {

        return Output()
    }
}
