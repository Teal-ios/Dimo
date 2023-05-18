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
    
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    
    struct Input {
        let categoryButtonTapped: PublishSubject<Void>
        let heroPlusButtonTapped: PublishSubject<Void>
        let characterPlusButtonTapped: PublishSubject<Void>
        let mbtiRecommendPlusButtonTapped: PublishSubject<Void>
        let hotMoviePlusButtonTapped: PublishSubject<Void>
        let posterCellSelected: PublishSubject<Void>
    }
    
    struct Output {
        
    }

    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.categoryButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showCategoryViewController()
        }
        .disposed(by: disposebag)
        
        input.posterCellSelected.bind { [weak self] _ in
            self?.coordinator?.showTabmanCoordinator()
        }
        .disposed(by: disposebag)
        
        input.heroPlusButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showContentMoreViewController(title: "ISFJ가 주인공인 영화")
        }
        .disposed(by: disposebag)
        
        input.characterPlusButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showContentMoreViewController(title: "캐릭터 모아보기")
        }
        .disposed(by: disposebag)
        
        input.mbtiRecommendPlusButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showContentMoreViewController(title: "추천한 영화")

        }
        .disposed(by: disposebag)
        
        input.hotMoviePlusButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showContentMoreViewController(title: "핫한 영화")
        }
        .disposed(by: disposebag)

        return Output()
    }
}
