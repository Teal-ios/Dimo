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
    private let characterDetailUseCase: CharacterDetailUseCase
    
    var disposeBag: DisposeBag = DisposeBag()
    var editProfileFinishTrigger: PublishRelay<ModifyMyProfileQuery>
    
    init(coordinator: MyMomentumCoordinator?, myMomentumUseCase: MyMomentumUseCase, characterDetailUseCase: CharacterDetailUseCase, editProfileFinishTrigger: PublishRelay<ModifyMyProfileQuery>) {
        self.coordinator = coordinator
        self.myMomentumUseCase = myMomentumUseCase
        self.characterDetailUseCase = characterDetailUseCase
        self.editProfileFinishTrigger = editProfileFinishTrigger
    }
    
    struct Input {
        let viewDidLoad: PublishRelay<Void>
        let editProfileButtonTap: ControlEvent<Void>
        let likeContentMoreButtonTap: ControlEvent<Void>
        let digFinishMoreButtonTap: ControlEvent<Void>
        let reviewMoreButtonTap: ControlEvent<Void>
        let commentMoreButtonTap: ControlEvent<Void>
        let myReviewCellSelected: PublishRelay<MyReview>
        let myCommentCellSelected: PublishRelay<MyComment>
        let myLikeContentCellSelected: PublishRelay<LikeContent>
        let myDigCharacterCellSelected: PublishRelay<MyVotedCharacter>
    }
    
    struct Output {
        let myProfileData: PublishRelay<MyProfile>
        let likeAnimationContentData: BehaviorRelay<LikeAnimationContent?>
        let likeMovieContentData: PublishRelay<LikeMovieContent>
        let likeButtonTapToNotificaiton: PublishRelay<Void>
        let myReviewList: PublishRelay<GetMyReview>
        let myCommentList: PublishRelay<GetMyComment>
        let myVotedCharacterList: PublishRelay<GetMyVotedCharacter>
        let editProfileFinishTrigger: PublishRelay<ModifyMyProfileQuery>
    }
    
    let myProfile = PublishRelay<MyProfile>()
    let likeAnimationContent = BehaviorRelay<LikeAnimationContent?>(value: nil)
    let likeMoviewContent = PublishRelay<LikeMovieContent>()
    let likeButtonTapToNotificationEventTrigger = PublishRelay<Void>()
    let likeButtonTapToHomeViewController = PublishRelay<Void>()
    let myReviewList = PublishRelay<GetMyReview>()
    let myCommentList = PublishRelay<GetMyComment>()
    let myVotedCharacterList = PublishRelay<GetMyVotedCharacter>()
    let getReivewDetail = PublishRelay<GetReviewDetail>()
    let characters = PublishRelay<Characters>()
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoad
            .debug()
            .bind { [weak self] _ in
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                
                self.getMyProfile(user_id: user_id)
                self.getLikeMoviewContent(user_id: user_id)
                self.getLikeAnimationwContent(user_id: user_id)
                self.getMyReview(user_id: user_id)
                self.getMyComment(user_id: user_id)
                self.getMyVotedCharacter(user_id: user_id)
            }
            .disposed(by: disposeBag)
        
        input.editProfileButtonTap
            .bind { [weak self] _ in
                guard let self else { return }
                self.coordinator?.showEditProfileViewController()
            }
            .disposed(by: disposeBag)
        
        input.likeContentMoreButtonTap
            .debug()
            .withUnretained(self)
            .withLatestFrom(self.likeAnimationContent)
            .bind { [weak self] likeAnimation in
                guard let self else { return }
                guard let likeAnimation else { return }
                self.coordinator?.showMyContentMoreViewController(likeContentList: likeAnimation.like_content_info)
            }
            .disposed(by: disposeBag)
        
        input.reviewMoreButtonTap
            .withLatestFrom(self.myReviewList)
            .bind { [weak self] myReviewList in
                guard let self = self else { return }
                self.coordinator?.showMyReviewMoreViewController(myReview: myReviewList.review)
            }
            .disposed(by: disposeBag)
        
        input.commentMoreButtonTap
            .withLatestFrom(self.myCommentList)
            .bind { [weak self] myCommentList in
                guard let self = self else { return }
                self.coordinator?.showMyCommentMoreViewController(myComment: myCommentList.comment)
            }
            .disposed(by: disposeBag)
        
        input.digFinishMoreButtonTap
            .withLatestFrom(self.myVotedCharacterList)
            .bind { [weak self] votedCharacterList in
                guard let self = self else { return }
                self.coordinator?.showMyCharacterMoreViewController(votedCharacterList: votedCharacterList.voted_character)
            }
            .disposed(by: disposeBag)
        
        likeButtonTapToNotificationEventTrigger
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .debug()
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                self.getMyProfile(user_id: user_id)
                self.getLikeMoviewContent(user_id: user_id)
                self.getLikeAnimationwContent(user_id: user_id)
            }
            .disposed(by: disposeBag)
        
        input.myReviewCellSelected
            .withUnretained(self)
            .bind { vm, myReview in
                vm.characters.accept(Characters(character_id: myReview.character_id, character_name: myReview.character_name, character_img: myReview.character_img, character_mbti: myReview.character_mbti))
                vm.getReviewList(user_id: myReview.user_id, character_id: myReview.character_id, review_id: myReview.review_id)
            }
            .disposed(by: disposeBag)
        
        input.myCommentCellSelected
            .withUnretained(self)
            .bind { vm, myComment in
                vm.characters.accept(Characters(character_id: myComment.character_id, character_name: myComment.character_name, character_img: myComment.character_img, character_mbti: myComment.character_mbti))
                vm.getReviewList(user_id: myComment.user_id, character_id: myComment.character_id, review_id: myComment.review_id)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(self.characters, self.getReivewDetail)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] character, review in
                guard let self = self else { return }
                print(review.review_list[0], "🍋")
                self.coordinator?.showTabmanCoordinator(character: character, review: review.review_list[0])
            }
            .disposed(by: disposeBag)
        
        input.myLikeContentCellSelected
            .withUnretained(self)
            .bind { vm, content in
                vm.coordinator?.showMovieDetailViewController(content_id: String(content.anime_id))
            }
            .disposed(by: disposeBag)
        
        input.myDigCharacterCellSelected
            .withUnretained(self)
            .bind { vm, character in
                vm.coordinator?.showTabmanCharacterCoordinator(character: Characters(character_id: character.character_id, character_name: character.character_name, character_img: character.character_img, character_mbti: character.character_mbti))
            }
            .disposed(by: disposeBag)
        
        editProfileFinishTrigger
            .withUnretained(self)
            .bind { owner, data in
                owner.getMyProfile(user_id: data.user_id)
            }
            .disposed(by: disposeBag)
        
        NotificationCenter.default.addObserver(self, selector: #selector(likeButtonTapToMovieDetailViewModel(_:)), name: NSNotification.Name("likeButtonTap"), object: nil)
        
        return Output(myProfileData: self.myProfile, likeAnimationContentData: self.likeAnimationContent, likeMovieContentData: self.likeMoviewContent, likeButtonTapToNotificaiton: self.likeButtonTapToNotificationEventTrigger, myReviewList: self.myReviewList, myCommentList: self.myCommentList, myVotedCharacterList: self.myVotedCharacterList, editProfileFinishTrigger: self.editProfileFinishTrigger)
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

extension MyMomentumViewModel {
    @objc
    func likeButtonTapToMovieDetailViewModel(_ notification: Notification) {
        self.likeButtonTapToNotificationEventTrigger.accept(())
    }
}

extension MyMomentumViewModel {
    private func getMyReview(user_id: String) {
        Task {
            let myReview = try await myMomentumUseCase.excuteMyReview(query: GetMyReviewQuery(user_id: user_id))
            print(myReview, "내리뷰 조회")
            self.myReviewList.accept(myReview)
        }
    }
}

extension MyMomentumViewModel {
    private func getMyComment(user_id: String) {
        Task {
            let myComment = try await myMomentumUseCase.excuteMyComment(query: GetMyCommentQuery(user_id: user_id))
            print(myComment, "내댓글 조회")
            self.myCommentList.accept(myComment)
        }
    }
}

extension MyMomentumViewModel {
    private func getMyVotedCharacter(user_id: String) {
        Task {
            let myVotedCharacter = try await myMomentumUseCase.excuteMyVotedCharacter(query: GetMyVotedCharacterQuery(user_id: user_id))
            print(myVotedCharacter, "투표한 캐릭터 조회")
            self.myVotedCharacterList.accept(myVotedCharacter)
        }
    }
}

extension MyMomentumViewModel {
    private func getReviewList(user_id: String, character_id: Int, review_id: Int) {
        Task {
            let getReivewDetail = try await characterDetailUseCase.excuteGetReviewDetail(query: GetReviewDetailQuery(user_id: user_id, character_id: character_id, review_id: review_id))
            print(getReivewDetail, "리뷰 전체 조회")
            self.getReivewDetail.accept(getReivewDetail)
        }
    }
}
