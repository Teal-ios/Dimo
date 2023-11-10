//
//  MyReviewMoreViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import Foundation
import RxSwift
import RxCocoa

enum DefineTrigger {
    case my
    case other
}

final class MyReviewMoreViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: MyMomentumCoordinator?
    private let characterDetailUseCase: CharacterDetailUseCase
    
    struct Input{
        let myReviewCellSelected: PublishRelay<MyReview>

    }
    
    struct Output{
        let myReview: BehaviorRelay<[MyReview?]>
        let defineTrigger: Observable<DefineTrigger>
        let otherNickname: Observable<String?>
    }
    
    init(coordinator: MyMomentumCoordinator?, characterDetailUseCase: CharacterDetailUseCase, myReview: [MyReview?], define: DefineTrigger, otherNickname: String?) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.myReview = BehaviorRelay(value: myReview)
        self.defineTrigger = define
        self.otherNickname = otherNickname
    }
    
    var myReview: BehaviorRelay<[MyReview?]> = BehaviorRelay(value: [])
    var defineTrigger: DefineTrigger
    var otherNickname: String?
    var character: Characters?
    let getReivewDetail = PublishRelay<GetReviewDetail>()

    func transform(input: Input) -> Output {
        
        input.myReviewCellSelected
            .withUnretained(self)
            .bind { owner, review in
                let character = Characters(character_id: review.character_id, character_name: review.character_name, character_img: review.character_img, character_mbti: review.character_mbti)
                owner.character = character
                owner.getReviewList(user_id: review.user_id, character_id: review.character_id, review_id: review.review_id)

            }
            .disposed(by: disposeBag)
        
        self.getReivewDetail
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { owner, data in
                guard let character = owner.character else { return  }
                owner.coordinator?.showTabmanCoordinator(character: character, review: data.review_list[0])
            }
            .disposed(by: disposeBag)

        return Output(myReview: self.myReview, defineTrigger: Observable.just(defineTrigger), otherNickname: Observable.just(otherNickname))
    }
}

extension MyReviewMoreViewModel {
    private func getReviewList(user_id: String, character_id: Int, review_id: Int) {
        Task {
            let getReivewDetail = try await characterDetailUseCase.excuteGetReviewDetail(query: GetReviewDetailQuery(user_id: user_id, character_id: character_id, review_id: review_id))
            print(getReivewDetail, "다른사람리뷰 전체 조회")
            self.getReivewDetail.accept(getReivewDetail)
        }
    }
}
