//
//  MovieDetailViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieDetailViewModel: ViewModelType {
    
    private weak var coordinator: HomeCoordinator?
    private let contentUseCase: ContentUseCase
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(coordinator: HomeCoordinator? = nil, contentUseCase: ContentUseCase, content_id: String) {
        self.coordinator = coordinator
        self.contentUseCase = contentUseCase
        self.contentId = BehaviorRelay(value: content_id)
    }
    
    struct Input{
        let plusButtonTapped: ControlEvent<Void>
        let evaluateButtonTapped: PublishSubject<Void>

    }
    
    struct Output{
        let plusButtonTapped: ControlEvent<Void>

    }
    
    var contentId = BehaviorRelay(value: "")
    let detailAnimationData = PublishRelay<DetailAnimationData>()
    
    func transform(input: Input) -> Output {
        input.evaluateButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            self.coordinator?.showMovieDetailRankViewController()
        }
        .disposed(by: disposeBag)
        
        self.contentId.bind { [weak self] contentId in
            guard let self else { return }
            self.getDetailAnimationViewController(content_id: contentId)
        }
        .disposed(by: disposeBag)
        
        return Output(plusButtonTapped: input.plusButtonTapped)
    }
}

extension MovieDetailViewModel {
    private func getDetailAnimationViewController(content_id: String) {
        Task {
            let detailAnimationData = try await contentUseCase.excuteFetchDetailAnimationData(query: DetailAnimationDataQuery(content_id: content_id))
            print(detailAnimationData)
            self.detailAnimationData.accept(detailAnimationData)
        }
    }
}
