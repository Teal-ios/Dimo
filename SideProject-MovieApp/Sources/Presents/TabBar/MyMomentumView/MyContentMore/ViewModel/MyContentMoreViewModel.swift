//
//  MyContentMoreViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/27.
//

import Foundation
import RxSwift
import RxCocoa

final class MyContentMoreViewModel: ViewModelType {
    
    private weak var coordinator: MyMomentumCoordinator?
    private let myMomentumUseCase: MyMomentumUseCase
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(coordinator: MyMomentumCoordinator?, myMomentumUseCase: MyMomentumUseCase, likeContent: [LikeContent?]) {
        self.coordinator = coordinator
        self.myMomentumUseCase = myMomentumUseCase
        self.likeContent = BehaviorRelay(value: likeContent)
    }
    
    var likeContent: BehaviorRelay<[LikeContent?]> = BehaviorRelay(value: [])
    
    struct Input {
        let viewDidLoadToSetDataSource: PublishRelay<Void>
        let myLikeContentCellSelected: PublishRelay<LikeContent>
    }
    
    struct Output {
        let likeContent: BehaviorRelay<[LikeContent?]>
        let viewDidLoadToSetDataSource: PublishRelay<Void>
    }
    
    func transform(input: Input) -> Output {
        
        input.myLikeContentCellSelected
            .withUnretained(self)
            .bind { vm, content in
                vm.coordinator?.showMovieDetailViewController(content_id: String(content.anime_id))
            }
            .disposed(by: disposeBag)
        
        return Output(likeContent: self.likeContent, viewDidLoadToSetDataSource: input.viewDidLoadToSetDataSource)
    }
}
