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
        let categoryButtonTapped: PublishSubject<String>
        let heroPlusButtonTapped: PublishSubject<Void>
        let characterPlusButtonTapped: PublishSubject<Void>
        let mbtiRecommendPlusButtonTapped: PublishSubject<Void>
        let hotMoviePlusButtonTapped: PublishSubject<Void>
        let posterCellSelected: PublishSubject<Void>
        let mbtiMovieCellSelected: PublishSubject<Void>
        let mbtiCharacterCellSelected: PublishSubject<Void>
        let mbtiRecommendCellSeleted: PublishSubject<Void>
        let hotMovieCellSelected: PublishSubject<Void>
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let animationData: PublishRelay<[AnimationData]>
        let category: BehaviorRelay<String>
    }
    
    var animationData = PublishRelay<[AnimationData]>()


    init(coordinator: HomeCoordinator?, contentUseCase: ContentUseCase, category: String) {
        self.coordinator = coordinator
        self.contentUseCase = contentUseCase
        self.category = BehaviorRelay(value: category)
    }
    
    func transform(input: Input) -> Output {
        input.categoryButtonTapped.bind { [weak self] text in
            self?.coordinator?.showCategoryViewController(category: text)
        }
        .disposed(by: disposeBag)
        
        input.posterCellSelected.bind { [weak self] _ in
            self?.coordinator?.showMovieDetailViewController()
        }
        .disposed(by: disposeBag)
        
        input.mbtiMovieCellSelected.bind { [weak self] _ in
            self?.coordinator?.showMovieDetailViewController()
        }
        .disposed(by: disposeBag)
        
        input.mbtiCharacterCellSelected.bind { [weak self] _ in
            self?.coordinator?.showTabmanCoordinator()
        }
        .disposed(by: disposeBag)
        
        
        input.heroPlusButtonTapped
            .bind { [weak self] _ in
            self?.coordinator?.showContentMoreViewController(title: "ISFJ가 주인공인 영화")
        }
        .disposed(by: disposeBag)
        
        input.characterPlusButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showCharacterMoreViewController()
        }
        .disposed(by: disposeBag)
        
        input.mbtiRecommendPlusButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showContentMoreViewController(title: "추천한 영화")

        }
        .disposed(by: disposeBag)
        
        input.hotMoviePlusButtonTapped.bind { [weak self] _ in

            self?.coordinator?.showContentMoreViewController(title: "핫한 영화")
        }
        .disposed(by: disposeBag)
        
        input.viewDidLoad
            .bind { [weak self] _ in
                print("viewDidLoad 실행")
                let animationDataObservable = self?.contentUseCase.excuteFetchAnimationData()
                
                animationDataObservable?.bind(onNext: { data in
                    self?.animationData.accept(data)
                })
            }
            .disposed(by: disposeBag)

        return Output(animationData: self.animationData, category: self.category)
    }
}
