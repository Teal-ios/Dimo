//
//  SearchViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/03.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteCoordinator?
    private var contentUseCase: ContentUseCase

    init(coordinator: VoteCoordinator?, contentUseCase: ContentUseCase) {
        self.coordinator = coordinator
        self.contentUseCase = contentUseCase
    }
    
    struct Input{
        let viewDidLoad: Observable<Void>
    }
    
    struct Output{
        let animationData: PublishRelay<[AnimationData]>
    }
    
    var animationData = PublishRelay<[AnimationData]>()

    
    func transform(input: Input) -> Output {
        
        input.viewDidLoad
            .bind { [weak self] _ in
                print("viewDidLoad 실행")

            }
            .disposed(by: disposeBag)
        
        return Output(animationData: self.animationData)
    }
}
