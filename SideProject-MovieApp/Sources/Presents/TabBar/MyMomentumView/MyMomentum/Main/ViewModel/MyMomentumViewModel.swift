//
//  MyMomentumViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import Foundation
import RxSwift
import RxCocoa

final class MyMomentumViewModel: ViewModelType {
    
    private weak var coordinator: MyMomentumCoordinator?
    private let myMomentumUseCase: MyMomentumUseCase
    
    var disposeBag: DisposeBag = DisposeBag()

    init(coordinator: MyMomentumCoordinator?, myMomentumUseCase: MyMomentumUseCase) {
        self.coordinator = coordinator
        self.myMomentumUseCase = myMomentumUseCase
    }
    
    struct Input {
        let viewDidLoad: PublishRelay<Void>
        let editProfileButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let myProfileData: PublishRelay<MyProfile>
        let likeAnimationContentData: PublishRelay<LikeAnimationContent>
        let likeMovieContentData: PublishRelay<LikeMovieContent>
    }
    
    let myProfile = PublishRelay<MyProfile>()
    let likeAnimationContent = PublishRelay<LikeAnimationContent>()
    let likeMoviewContent = PublishRelay<LikeMovieContent>()
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoad
            .debug()
            .bind { [weak self] _ in
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                
                self.getMyProfile(user_id: user_id)
                self.getLikeMoviewContent(user_id: user_id)
                self.getLikeAnimationwContent(user_id: user_id)
            }
            .disposed(by: disposeBag)
        
        input.editProfileButtonTap
            .debug()
            .bind { [weak self] _ in
                guard let self else { return }
                self.coordinator?.showEditProfileViewController()
                print("몇번 울리니")
            }
            .disposed(by: disposeBag)
        
        
        return Output(myProfileData: self.myProfile, likeAnimationContentData: self.likeAnimationContent, likeMovieContentData: self.likeMoviewContent)
    }
}

extension MyMomentumViewModel {
    private func getMyProfile(user_id: String) {
        Task {
            let myProfile = try await myMomentumUseCase.excuteMyProfile(query: MyProfileQuery(user_id: user_id))
            print(myProfile, "내 프로필 조회")
            self.myProfile.accept(myProfile)
        }
    }
}

extension MyMomentumViewModel {
    private func getLikeMoviewContent(user_id: String) {
        Task {
            let likeMovieContent = try await myMomentumUseCase.excuteLikeMovieContent(query: LikeMovieContentQuery(user_id: user_id))
            print(likeMovieContent, "내가 좋아요를 누른 영화 조회")
            self.likeMoviewContent.accept(likeMovieContent)
        }
    }
}

extension MyMomentumViewModel {
    private func getLikeAnimationwContent(user_id: String) {
        Task {
            let likeAnimationContent = try await myMomentumUseCase.excuteLikeAnimationContent(query: LikeAnimationContentQuery(user_id: user_id))
            print(likeAnimationContent, "내가 좋아요를 누른 애니메이션 조회")
            self.likeAnimationContent.accept(likeAnimationContent)
        }
    }
}
