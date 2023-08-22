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
    
    init(coordinator: HomeCoordinator? = nil, contentUseCase: ContentUseCase, content_id: String, gradeFinish: PublishRelay<Int>) {
        self.coordinator = coordinator
        self.contentUseCase = contentUseCase
        self.contentId = BehaviorRelay(value: content_id)
        self.gradeFinish = gradeFinish
    }
    
    struct Input{
        let plusButtonTapped: ControlEvent<Void>
        let evaluateButtonTapped: ControlEvent<Void>
        let likeButtonTapped: ControlEvent<Void>
        let likeContentCheckValid: PublishRelay<Bool>
        let characterCellSelected: PublishRelay<Characters>
        let backButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
        let plusButtonTapped: ControlEvent<Void>
        let animationData: PublishRelay<DetailAnimationData>
        let characterData: PublishRelay<[Characters]>
        let likeButtonTapped: ControlEvent<Void>
        let likeChoice: PublishRelay<LikeChoice>
        let likeCancel: PublishRelay<LikeCancel>
        let likeContentCheck: PublishRelay<LikeContentCheck>
        let gradeFinish: PublishRelay<Int>
        let evaluateMbti: PublishRelay<GetEvaluateMbti>
        let gradeEvaluateResult: PublishRelay<GetGradeEvaluateResult>
        let mostLikeChoiceMbti: PublishRelay<MostLikeChoiceMbti>
    }
    
    var contentId = BehaviorRelay(value: "")
    let detailAnimationData = PublishRelay<DetailAnimationData>()
    let characterData = PublishRelay<[Characters]>()
    let likeChoice = PublishRelay<LikeChoice>()
    let likeCancel = PublishRelay<LikeCancel>()
    let likeContentCheck = PublishRelay<LikeContentCheck>()
    var gradeFinish = PublishRelay<Int>()
    let evaluateMbti = PublishRelay<GetEvaluateMbti>()
    let gradeEvaluateResult = PublishRelay<GetGradeEvaluateResult>()
    let mostLikeChoiceMbti = PublishRelay<MostLikeChoiceMbti>()
    
    func transform(input: Input) -> Output {
        
        var nextContentId: String = ""
        
        input.evaluateButtonTapped
            .withLatestFrom(self.contentId)
            .withUnretained(self)
            .bind { vm, contentId in
                vm.coordinator?.showMovieDetailEvaluateViewController(content_id: contentId)
            }
            .disposed(by: disposeBag)
        
        self.contentId.bind { [weak self] contentId in
            guard let self else { return }
            guard let user_id = UserDefaultManager.userId else { return }
            let contentType = "anime"
            self.getDetailAnimationViewController(content_id: contentId)
            self.getLikeContentCheck(user_id: user_id, content_type: contentType, contentId: contentId)
            self.getEvaluateMbti(contentId: contentId, content_type: contentType)
            self.getGradeEvaluateResult(user_id: user_id, contentId: contentId, content_type: contentType)
            self.getMostLikeChoiceMbti(user_id: user_id, contentId: contentId, content_type: contentType)
            nextContentId = contentId
        }
        .disposed(by: disposeBag)
        
        input.likeContentCheckValid.bind { [weak self] likeContentCheck in
            guard let self else { return }
            guard let user_id = UserDefaultManager.userId else { return }
            if likeContentCheck == true {
                print("컨텐츠가 있다면")
                self.postLikeCancel(user_id: user_id, content_type: "anime", contentId: nextContentId)
            } else {
                print("컨텐츠가 없다면")
                self.postLikeChoice(user_id: user_id, content_type: "anime", contentId: nextContentId)
            }
        }
        .disposed(by: disposeBag)
        
        input.characterCellSelected
            .withUnretained(self)
            .bind { vm, character in
                vm.coordinator?.showTabmanCoordinator(character: character)
            }
            .disposed(by: disposeBag)
        
        input.backButtonTapped
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.popViewController()
            }
            .disposed(by: disposeBag)
        
        return Output(plusButtonTapped: input.plusButtonTapped, animationData: self.detailAnimationData, characterData: self.characterData, likeButtonTapped: input.likeButtonTapped, likeChoice: self.likeChoice, likeCancel: self.likeCancel, likeContentCheck: self.likeContentCheck, gradeFinish: self.gradeFinish, evaluateMbti: self.evaluateMbti, gradeEvaluateResult: self.gradeEvaluateResult, mostLikeChoiceMbti: self.mostLikeChoiceMbti)
    }
}

extension MovieDetailViewModel {
    private func getDetailAnimationViewController(content_id: String) {
        Task {
            let detailAnimationData = try await contentUseCase.excuteFetchDetailAnimationData(query: DetailAnimationDataQuery(content_id: content_id))
            print(detailAnimationData)
            self.detailAnimationData.accept(detailAnimationData)
            self.characterData.accept(detailAnimationData.characters)
        }
    }
}

extension MovieDetailViewModel {
    private func postLikeChoice(user_id: String, content_type: String, contentId: String) {
        Task {
            let likeChoice = try await contentUseCase.excuteLikeChoice(query: LikeChoiceQuery(user_id: user_id, content_type: content_type, contentId: contentId))
            print(likeChoice, "좋아요를 눌렀어~~")
            self.likeChoice.accept(likeChoice)
            NotificationCenter.default.post(name: NSNotification.Name("likeButtonTap"), object: ())
        }
    }
}

extension MovieDetailViewModel {
    private func postLikeCancel(user_id: String, content_type: String, contentId: String) {
        Task {
            let likeCancel = try await contentUseCase.excuteLikeCancel(query: LikeCancelQuery(user_id: user_id, content_type: content_type, contentId: contentId))
            print(likeChoice, "좋아요를 취소했습니다~~")
            self.likeCancel.accept(likeCancel)
            NotificationCenter.default.post(name: NSNotification.Name("likeButtonTap"), object: ())
        }
    }
}

extension MovieDetailViewModel {
    private func getLikeContentCheck(user_id: String, content_type: String, contentId: String) {
        Task {
            let likeContentCheck = try await contentUseCase.excuteLikeContentCheck(query: LikeContentCheckQuery(user_id: user_id, content_type: content_type, contentId: contentId))
            print(likeContentCheck, "좋아요를 누른 컨텐츠인지 확인")
            self.likeContentCheck.accept(likeContentCheck)
        }
    }
}

extension MovieDetailViewModel {
    private func getEvaluateMbti(contentId: String, content_type: String) {
        Task {
            let evalateMbti = try await contentUseCase.excuteGetEvaluateMbti(query: GetEvaluateMbtiQuery(contentId: contentId, content_type: content_type))
            print(evalateMbti, "엠비티아이 평가 조회 완료")
            self.evaluateMbti.accept(evalateMbti)
        }
    }
}

extension MovieDetailViewModel {
    private func getGradeEvaluateResult(user_id: String, contentId: String, content_type: String) {
        Task {
            let gradeEvaluateResult = try await contentUseCase.excuteGetGradeEvaluateResult(query: GetGradeEvaluateResultQuery(user_id: user_id, contentId: contentId, content_type: content_type))
            print(gradeEvaluateResult, "평가여부 평가 조회 완료")
            self.gradeEvaluateResult.accept(gradeEvaluateResult)
        }
    }
}

extension MovieDetailViewModel {
    private func getMostLikeChoiceMbti(user_id: String, contentId: String, content_type: String) {
        Task {
            let mostLikeChoiceMbti = try await contentUseCase.excuteMostLikeChoiceMbti(query: MostLikeChoiceMbtiQuery(user_id: user_id, content_type: content_type, contentId: contentId))
            print(mostLikeChoiceMbti, "가장 많이 찜 누른 mbti")
            self.mostLikeChoiceMbti.accept(mostLikeChoiceMbti)
        }
    }
}
