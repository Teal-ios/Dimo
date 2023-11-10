//
//  MyCommentMoreViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import Foundation
import RxSwift
import RxCocoa

final class MyCommentMoreViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: MyMomentumCoordinator?
    private let characterDetailUseCase: CharacterDetailUseCase
    
    struct Input{
        let myCommentCellSelected: PublishRelay<MyComment>
    }
    
    struct Output{
        let myComment: BehaviorRelay<[MyComment?]>
    }
    
    init(coordinator: MyMomentumCoordinator?, characterUseCase: CharacterDetailUseCase, myComment: [MyComment?]) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterUseCase
        self.myComment = BehaviorRelay(value: myComment)
    }
    
    var myComment: BehaviorRelay<[MyComment?]> = BehaviorRelay(value: [])
    let getReivewDetail = PublishRelay<GetReviewDetail>()
    var character: Characters?
    
    func transform(input: Input) -> Output {
        
        input.myCommentCellSelected
            .withUnretained(self)
            .bind { vm, myComment in
                vm.character = (Characters(character_id: myComment.character_id, character_name: myComment.character_name, character_img: myComment.character_img, character_mbti: myComment.character_mbti))
                vm.getReviewList(user_id: myComment.user_id, character_id: myComment.character_id, review_id: myComment.review_id)
            }
            .disposed(by: disposeBag)
        
        self.getReivewDetail
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { owner, comment in
                guard let character = owner.character else { return }
                owner.coordinator?.showTabmanCoordinator(character: character, review: comment.review_list[0])
            }
            .disposed(by: disposeBag)
        
        return Output(myComment: self.myComment)
    }
}

extension MyCommentMoreViewModel {
    private func getReviewList(user_id: String, character_id: Int, review_id: Int) {
        Task {
            let getReivewDetail = try await characterDetailUseCase.excuteGetReviewDetail(query: GetReviewDetailQuery(user_id: user_id, character_id: character_id, review_id: review_id))
            print(getReivewDetail, "리뷰 전체 조회")
            self.getReivewDetail.accept(getReivewDetail)
        }
    }
}
