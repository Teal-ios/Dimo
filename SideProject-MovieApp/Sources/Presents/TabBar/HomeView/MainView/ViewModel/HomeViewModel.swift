//
//  HomeViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    private var contentUseCase: ContentUseCase
    private var category: BehaviorRelay<String>

    struct Input {
        let categoryButtonTapped: Signal<String>
//        let categoryButtonTapped: PublishSubject<String>
        let heroPlusButtonTapped: ControlEvent<Void>
        let characterPlusButtonTapped: ControlEvent<Void>
        let mbtiRecommendPlusButtonTapped: ControlEvent<Void>
        let hotMoviePlusButtonTapped: ControlEvent<Void>
        let posterCellSelected: PublishRelay<String>
        let mbtiHeroCellSelected: PublishRelay<String>
//        let mbtiCharacterCellSelected: PublishRelay<String>
        let mbtiRecommendCellSeleted: PublishRelay<String>
        let hotMovieCellSelected: PublishRelay<String>
        let viewDidLoad: PublishRelay<Void>
        let okAlertButtonTapped: ControlEvent<Void>
        let cancelAlertButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let animationData: PublishRelay<AnimationData>
        let category: BehaviorRelay<String>
//        let categoryButtonTapped: PublishRelay<String>
        let characterPlusButtonTapped: ControlEvent<Void>
        let cancelAlertButtonTapped: ControlEvent<Void>
        let okAlertButtonTapped: ControlEvent<Void>
    }
    
    let animationData = PublishRelay<AnimationData>()

    init(coordinator: HomeCoordinator?, contentUseCase: ContentUseCase, category: String) {
        self.coordinator = coordinator
        self.contentUseCase = contentUseCase
        self.category = BehaviorRelay(value: category)
    }
    
    func transform(input: Input) -> Output {
        input.categoryButtonTapped
            .emit { [weak self] category in
            guard let self else { return }
            self.category.accept(category)
            self.coordinator?.showCategoryViewController(category: self.category)
        }
        .disposed(by: disposeBag)
        
        input.posterCellSelected
            .withUnretained(self)
            .bind { vm, contentId in
            vm.coordinator?.showMovieDetailViewController(content_id: contentId)
        }
        .disposed(by: disposeBag)
        
        input.mbtiHeroCellSelected
            .withUnretained(self)
            .bind { vm, contentId in
            vm.coordinator?.showMovieDetailViewController(content_id: contentId)
        }
        .disposed(by: disposeBag)
        
        input.heroPlusButtonTapped
            .withLatestFrom(self.animationData)
            .withUnretained(self)
            .bind { vm, data in
                var contentSuccessData: [Hit] = []
                for i in 0...4 {
                    if data.contents[i].same_mbti_anime != nil {
                        guard let success = data.contents[i].same_mbti_anime else { return }
                        contentSuccessData = success
                    }
                }
                vm.coordinator?.showContentMoreViewController(title: "ISFJ가 주인공인 영화", content: contentSuccessData)
            }
            .disposed(by: disposeBag)
        
        input.hotMoviePlusButtonTapped
            .withLatestFrom(self.animationData)
            .withUnretained(self)
            .bind { vm, data in
                var contentSuccessData: [Hit] = []
                for i in 0...4 {
                    if data.contents[i].hit != nil {
                        guard let success = data.contents[i].hit else { return }
                        contentSuccessData = success
                    }
                }
                vm.coordinator?.showContentMoreViewController(title: "지금 핫한 영화", content: contentSuccessData)
            }
            .disposed(by: disposeBag)
        
        input.mbtiRecommendPlusButtonTapped
            .withLatestFrom(self.animationData)
            .withUnretained(self)
            .bind { vm, data in
                var contentSuccessData: [Hit] = []
                for i in 0...4 {
                    if data.contents[i].recommend != nil {
                        guard let success = data.contents[i].recommend else { return }
                        contentSuccessData = success
                    }
                }
                vm.coordinator?.showContentMoreViewController(title: "ISFJ가 관심있는 영화/애니", content: contentSuccessData)
            }
            .disposed(by: disposeBag)
        
//        input.characterPlusButtonTapped
//            .withUnretained(self)
//            .bind { vm, _ in
//            vm.coordinator?.showSpoilerAlertViewController()
//        }
//        .disposed(by: disposeBag)
        
        input.mbtiRecommendCellSeleted
            .withUnretained(self)
            .bind { vm, contentId in
            vm.coordinator?.showMovieDetailViewController(content_id: contentId)
        }
        .disposed(by: disposeBag)
        
        input.hotMovieCellSelected
            .withUnretained(self)
            .bind { vm, contentId in
            vm.coordinator?.showMovieDetailViewController(content_id: contentId)
        }
        .disposed(by: disposeBag)
        
        input.viewDidLoad
            .bind { [weak self] _ in
                print("viewDidLoad 실행")
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                self.getAnimationDataList(user_id: user_id)
            }
            .disposed(by: disposeBag)
        
        input.okAlertButtonTapped
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.showCharacterMoreViewController()
            }
            .disposed(by: disposeBag)

        return Output(animationData: self.animationData, category: self.category, characterPlusButtonTapped: input.characterPlusButtonTapped, cancelAlertButtonTapped: input.cancelAlertButtonTapped, okAlertButtonTapped: input.okAlertButtonTapped)
    }
}

extension HomeViewModel {
    private func getAnimationDataList(user_id: String) {
        Task {
            let animationData = try await contentUseCase.excuteFetchAnimationData(query: GetAnimationQuery(user_id: user_id))
            print(animationData, "애니메이션 데이터 들어옴")
            self.animationData.accept(animationData)
        }
    }
}
