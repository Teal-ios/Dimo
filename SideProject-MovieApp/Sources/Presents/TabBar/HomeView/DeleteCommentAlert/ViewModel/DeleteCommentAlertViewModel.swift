//
//  DeleteCommentAlertViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol sendDeleteCommentDelegate {
    func sendDeleteComment()
}

final class DeleteCommentAlertViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private let characterDetailUseCase: CharacterDetailUseCase
    private var comment: CommentList
    var delegate: sendDeleteCommentDelegate?
    
    struct Input{
        let okButtonTapped: ControlEvent<Void>
        let cancelButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
        
    }
        
    init(coordinator: TabmanCoordinator?, characterDetailUseCase: CharacterDetailUseCase, comment: CommentList) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.comment = comment
    }
    
    let deleteComment = PublishRelay<DeleteComment>()
    
    func transform(input: Input) -> Output {
        input.okButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            deleteComment(user_id: comment.user_id,
                          character_id: comment.character_id,
                          review_id: comment.review_id,
                          comment_id: comment.comment_id)
        }
        .disposed(by: disposeBag)
        
        self.deleteComment
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.dismissViewController()
                vm.delegate?.sendDeleteComment()
            }
            .disposed(by: disposeBag)
        
        input.cancelButtonTapped
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
            guard let self = self else { return}
            self.coordinator?.dismissViewController()
        }
        .disposed(by: disposeBag)
        
        return Output()
    }
}

extension DeleteCommentAlertViewModel {
    private func deleteComment(user_id: String, character_id: Int , review_id: Int, comment_id: Int) {
        Task {
            let deleteComment = try await characterDetailUseCase.excuteDeleteComment(query: DeleteCommentQuery(user_id: user_id, character_id: character_id, review_id: review_id, comment_id: comment_id))
            print(deleteComment, "🍊 댓글 삭제")
            self.deleteComment.accept(deleteComment)
        }
    }
}
