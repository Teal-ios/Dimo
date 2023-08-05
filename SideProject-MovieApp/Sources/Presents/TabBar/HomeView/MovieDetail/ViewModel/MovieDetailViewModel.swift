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
        let evaluateButtonTapped: ControlEvent<Void>
        let likeButtonTapped: ControlEvent<Void>
        let likeContentCheckValid: PublishRelay<Bool>
        let characterCellSelected: PublishRelay<Characters>
    }
    
    struct Output{
        let plusButtonTapped: ControlEvent<Void>
        let animationData: PublishRelay<DetailAnimationData>
        let characterData: PublishRelay<[Characters]>
        let likeButtonTapped: ControlEvent<Void>
        let likeChoice: PublishRelay<LikeChoice>
        let likeCancel: PublishRelay<LikeCancel>
        let likeContentCheck: PublishRelay<LikeContentCheck>
    }
    
    var contentId = BehaviorRelay(value: "")
    let detailAnimationData = PublishRelay<DetailAnimationData>()
    let characterData = PublishRelay<[Characters]>()
    let likeChoice = PublishRelay<LikeChoice>()
    let likeCancel = PublishRelay<LikeCancel>()
    let likeContentCheck = PublishRelay<LikeContentCheck>()
    
    
    func transform(input: Input) -> Output {
        
        var nextContentId: String = ""
        
        input.evaluateButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            self.coordinator?.showMovieDetailRankViewController()
        }
        .disposed(by: disposeBag)
        
        self.contentId.bind { [weak self] contentId in
            guard let self else { return }
            guard let user_id = UserDefaultManager.userId else { return }
            
            self.getDetailAnimationViewController(content_id: contentId)
            self.getLikeContentCheck(user_id: user_id, content_type: "anime", contentId: contentId)
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
        
        return Output(plusButtonTapped: input.plusButtonTapped, animationData: self.detailAnimationData, characterData: self.characterData, likeButtonTapped: input.likeButtonTapped, likeChoice: self.likeChoice, likeCancel: self.likeCancel, likeContentCheck: self.likeContentCheck)
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
