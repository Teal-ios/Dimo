//
//  MyCommentMoreViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import Foundation
import RxSwift
import RxCocoa

final class MyCommentMoreViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: MyMomentumCoordinator?
    
    struct Input{


    }
    
    struct Output{
        let myComment: BehaviorRelay<[MyComment?]>
    }
    
    init(coordinator: MyMomentumCoordinator?, myComment: [MyComment?]) {
        self.coordinator = coordinator
        self.myComment = BehaviorRelay(value: myComment)
    }
    
    var myComment: BehaviorRelay<[MyComment?]> = BehaviorRelay(value: [])
    
    func transform(input: Input) -> Output {

        return Output(myComment: self.myComment)
    }
}
