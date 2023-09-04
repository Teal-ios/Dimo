//
//  MyReviewMoreViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import Foundation
import RxSwift
import RxCocoa

final class MyReviewMoreViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: MyMomentumCoordinator?
    
    struct Input{


    }
    
    struct Output{
        let myReview: BehaviorRelay<[MyReview?]>
    }
    
    init(coordinator: MyMomentumCoordinator?, myReview: [MyReview?]) {
        self.coordinator = coordinator
        self.myReview = BehaviorRelay(value: myReview)
    }
    
    var myReview: BehaviorRelay<[MyReview?]> = BehaviorRelay(value: [])
    
    func transform(input: Input) -> Output {

        return Output(myReview: self.myReview)
    }
}
