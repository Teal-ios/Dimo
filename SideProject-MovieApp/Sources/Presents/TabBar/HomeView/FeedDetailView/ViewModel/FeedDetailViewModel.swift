//
//  FeedDetailViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedDetailViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private let characterDetailUseCase: CharacterDetailUseCase
    var review: BehaviorRelay<ReviewList>
    
    struct Input{
        let plusNavigationButtonTapped: PublishSubject<Void>
        let spoilerButtonTapped: ControlEvent<Void>
        let commentText: ControlProperty<String?>
        let viewDidLoad: PublishRelay<Void>
        let commentRegisterButtonTap: ControlEvent<Void>
        let likeButtonTapped: ControlEvent<Void>
        let commentCellSelected: PublishRelay<CommentList>
    }
    
    struct Output{
        let spoilerValid: BehaviorRelay<Bool>
        let textValid: BehaviorRelay<Bool>
        let review: BehaviorRelay<ReviewList>
        let commentList: PublishRelay<[CommentList?]>
        let postCommentSuccess: PublishRelay<PostComment>
        let reviewDetail: PublishRelay<GetReviewDetail>
        let reviewLikeValid: BehaviorRelay<Bool>
    }
    
    init(coordinator: TabmanCoordinator? = nil, characterDetailUseCase: CharacterDetailUseCase, review: ReviewList) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.review = BehaviorRelay(value: review)
    }
    
    let getCommentList = PublishRelay<[CommentList?]>()
    let postComment = PublishRelay<PostComment>()
    let spoilerValid = BehaviorRelay(value: false)
    let textValid = BehaviorRelay(value: false)
    let commentText = BehaviorRelay(value: "")
    let getReviewDetail = PublishRelay<GetReviewDetail>()
    let reviewLikeValid = BehaviorRelay(value: false)
    
    func transform(input: Input) -> Output {
        //MARK: 여기까지함. 이제 다른 사람 리뷰이면 다른 창 뜨게 창만들어야함
        input.plusNavigationButtonTapped
            .withLatestFrom(self.review)
            .withUnretained(self)
            .bind { vm, review in
                guard let user_id = UserDefaultManager.userId else { return }
                if review.user_id == user_id {
                    vm.coordinator?.showFeedDetailMoreMyViewMController()
                } else {
                    vm.coordinator?.showFeedDetailMoreAnotherViewMController()
                }
            }
            .disposed(by: disposeBag)
        
        input.spoilerButtonTapped
            .withUnretained(self)
            .map { [weak self] _ in
                // 여기에 원하는 조건을 추가하여 Bool 값을 변환할 수 있습니다.
                return !(self?.spoilerValid.value ?? false)
            }
            .bind(to: spoilerValid) // 변환한 값을 spoilerValid에 바인딩
            .disposed(by: disposeBag)
        
        input.commentText
            .bind { [weak self] text in
                guard let self else { return }
                if text?.count == 0 {
                    self.textValid.accept(false)
                } else {
                    self.textValid.accept(true)
                }
            }
            .disposed(by: disposeBag)
        
        input.commentText
            .bind { [weak self] text in
                guard let self else { return }
                guard let text else { return }
                self.commentText.accept(text)
            }
            .disposed(by: disposeBag)
        
        input.viewDidLoad
            .withLatestFrom(self.review)
            .bind { [weak self] review in
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                self.getCommentList(user_id: user_id, review_id: review.review_id)
                self.getReviewDetail(user_id: user_id, character_id: review.character_id, review_id: review.review_id)
            }
            .disposed(by: disposeBag)

        let postCommentQueryData = Observable.combineLatest(self.review, self.spoilerValid, self.textValid, self.commentText)
        
        input.commentRegisterButtonTap
            .withLatestFrom(postCommentQueryData)
            .bind { [weak self] review, spoilerValid, textValid, text in
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                if textValid {
                    switch spoilerValid {
                    case true:
                        self.postCommentList(user_id: user_id, character_id: review.character_id, review_id: review.review_id, comment_content: text, comment_spoiler: 1)
                    case false:
                        self.postCommentList(user_id: user_id, character_id: review.character_id, review_id: review.review_id, comment_content: text, comment_spoiler: 0)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        self.postComment
            .withLatestFrom(self.review)
            .bind { [weak self] review in
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                self.getCommentList(user_id: user_id, review_id: review.review_id)
            }
            .disposed(by: disposeBag)
        
        input.likeButtonTapped
            .withLatestFrom(self.getReviewDetail)
            .withUnretained(self)
            .bind { vm, reviewDetail in
                let reviewLikeValid = vm.reviewLikeValid.value
                switch reviewLikeValid {

                case true:
                    vm.postReviewLikeCancel(user_id: reviewDetail.user_id, character_id: reviewDetail.review_list[0].character_id, review_id: reviewDetail.review_list[0].review_id)
                case false:
                    vm.postReviewLike(user_id: reviewDetail.user_id, character_id: reviewDetail.review_list[0].character_id, review_id: reviewDetail.review_list[0].review_id)
                }
            }
            .disposed(by: disposeBag)
        
        self.getReviewDetail
            .withUnretained(self)
            .bind { vm, reviewDetail in
                reviewDetail.is_liked == nil ? vm.reviewLikeValid.accept(false) : vm.reviewLikeValid.accept(true)
            }
            .disposed(by: disposeBag)
        
        return Output(spoilerValid: self.spoilerValid, textValid: self.textValid, review: self.review, commentList: self.getCommentList, postCommentSuccess: self.postComment, reviewDetail: self.getReviewDetail, reviewLikeValid: self.reviewLikeValid)
    }
}

extension FeedDetailViewModel {
    private func getCommentList(user_id: String, review_id: Int) {
        Task {
            let getCommentList = try await characterDetailUseCase.excuteGetComment(query: GetCommentQuery(user_id: user_id, review_id: review_id))
            print(getCommentList, "댓글 조회")
            self.getCommentList.accept(getCommentList.comment_list)
        }
    }
}

extension FeedDetailViewModel {
    private func postCommentList(user_id: String, character_id: Int, review_id: Int, comment_content: String, comment_spoiler: Int) {
        Task {
            let query = PostCommentQuery(user_id: user_id, character_id: character_id, review_id: review_id, comment_content: comment_content, comment_spoiler: comment_spoiler)
            let postComment = try await characterDetailUseCase.excutePostComment(query: query)
            print(postComment, "댓글 작성 성공")
            self.postComment.accept(postComment)
        }
    }
}

extension FeedDetailViewModel {
    private func getReviewDetail(user_id: String, character_id: Int, review_id: Int) {
        Task {
            let query = GetReviewDetailQuery(user_id: user_id, character_id: character_id, review_id: review_id)
            let getReviewDetail = try await characterDetailUseCase.excuteGetReviewDetail(query: query)
            print(getReviewDetail,"상세 조회 성공")
            self.getReviewDetail.accept(getReviewDetail)
        }
    }
}

extension FeedDetailViewModel {
    private func postReviewLike(user_id: String, character_id: Int, review_id: Int) {
        Task {
            let query = LikeReviewChoiceQuery(user_id: user_id, character_id: character_id, review_id: review_id)
            let reviewLike = try await characterDetailUseCase.excuteLikeReviewChoice(query: query)
            print(reviewLike, "리뷰 좋아요 누름")
            self.reviewLikeValid.accept(true)
        }
    }
}

extension FeedDetailViewModel {
    private func postReviewLikeCancel(user_id: String, character_id: Int, review_id: Int) {
        Task {
            let query = LikeReviewCancelQuery(user_id: user_id, character_id: character_id, review_id: review_id)
            let reviewLike = try await characterDetailUseCase.excuteLikeReviewCancel(query: query)
            print(reviewLike, "리뷰 좋아요 취소 누름")
            self.reviewLikeValid.accept(false)
        }
    }
}
