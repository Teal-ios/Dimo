//
//  ModifyCommentViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol modifyCommentDismissDelegate {
    func dismiss()
}

final class ModifyCommentViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private let comment: CommentList

    struct Input{
        let deleteButtonTapped: ControlEvent<Void>
        let backgroundButtonTapped: ControlEvent<Void>

    }
    
    struct Output{
    }
    
    var delegate: modifyCommentDismissDelegate?
    
    init(coordinator: TabmanCoordinator?, comment: CommentList) {
        self.coordinator = coordinator
        self.comment = comment
    }
    
    func transform(input: Input) -> Output {
        
        input.deleteButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.dismissViewController()
            self.coordinator?.showDeleteCommentAlertViewController(comment: self.comment)
        }.disposed(by: disposeBag)
        
        input.backgroundButtonTapped
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vm, _ in
                vm.delegate?.dismiss()
                vm.coordinator?.dismissViewController()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
