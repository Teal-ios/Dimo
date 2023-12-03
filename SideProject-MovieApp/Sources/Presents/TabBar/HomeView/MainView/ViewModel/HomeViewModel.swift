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
    private let myMomentumUseCase: MyMomentumUseCase
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
    var mbti = BehaviorRelay<String>(value: "")

    init(coordinator: HomeCoordinator?, contentUseCase: ContentUseCase, myMomentumUseCase: MyMomentumUseCase, category: String) {
        self.coordinator = coordinator
        self.contentUseCase = contentUseCase
        self.myMomentumUseCase = myMomentumUseCase
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
                let mbti = UserDefaultManager.mbti ?? "ISFJ"
                vm.coordinator?.showContentMoreViewController(title: "\(mbti)가 주인공인 영화", content: contentSuccessData)
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
                let mbti = UserDefaultManager.mbti ?? "ISFJ"
                vm.coordinator?.showContentMoreViewController(title: "\(mbti)가 관심있는 영화/애니", content: contentSuccessData)
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
            .withUnretained(self)
            .bind { vm, _ in
                guard let userId = UserDefaultManager.userId else { return }
                vm.getMyProfile(user_id: userId)
                vm.getAnimationDataList(user_id: userId)
            }
            .disposed(by: disposeBag)
        
//        input.okAlertButtonTapped
//            .withUnretained(self)
//            .bind { vm, _ in
//                vm.coordinator?.showCharacterMoreViewController()
//            }
//            .disposed(by: disposeBag)
//
        input.okAlertButtonTapped
            .withLatestFrom(self.animationData)
            .withUnretained(self)
            .bind { vm, anime in
                for content in anime.contents {
                    if content.category == "same_mbti_character" {
                        guard let character = content.same_mbti_char else { return }
                        vm.coordinator?.showCharacterMoreViewController(characterData: character)
                    }
                }
            }
            .disposed(by: disposeBag)

        return Output(animationData: self.animationData,
                      category: self.category,
                      characterPlusButtonTapped: input.characterPlusButtonTapped,
                      cancelAlertButtonTapped: input.cancelAlertButtonTapped,
                      okAlertButtonTapped: input.okAlertButtonTapped)
    }
}

extension HomeViewModel {
    private func getAnimationDataList(user_id: String) {
        Task {
            let animationData = try await contentUseCase.excuteFetchAnimationData(query: GetAnimationQuery(user_id: user_id))
            #if DEBUG
            print("⭐️ Animation Data: ", animationData)
            #endif
            self.animationData.accept(animationData)
        }
    }
}

extension HomeViewModel {
    private func getMyProfile(user_id: String) {
        Task {
            let myProfile = try await myMomentumUseCase.excuteMyProfile(query: MyProfileQuery(user_id: user_id))
            
            if myProfile.code == 200 {
                #if DEBUG
                print("⭐️ My Profile: \(myProfile)")
                #endif
                self.saveUserInformation(userId: myProfile.user_id,
                                         userName: myProfile.name,
                                         nickname: myProfile.nickname,
                                         mbti: myProfile.mbti)
                self.mbti.accept(myProfile.mbti)
            }
        }
    }
}

// MARK: - UserDefaultManager
extension HomeViewModel {
    private func saveUserInformation(userId: String, userName: String, nickname: String, mbti: String) {
        UserDefaultManager.userId = userId
        UserDefaultManager.userName = userName
        UserDefaultManager.nickname = nickname
        UserDefaultManager.mbti = mbti
    }
}
