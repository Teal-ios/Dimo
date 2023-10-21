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
    
    let deleteReview = PublishRelay<DeleteReview>()
    
    init(coordinator: TabmanCoordinator?, characterDetailUseCase: CharacterDetailUseCase, comment: CommentList) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.comment = comment
    }
    
    func transform(input: Input) -> Output {
        input.okButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
        }
        .disposed(by: disposeBag)
        
        self.deleteReview
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
