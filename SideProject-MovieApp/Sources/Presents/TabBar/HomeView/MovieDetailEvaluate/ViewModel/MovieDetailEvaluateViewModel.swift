//
//  MovieDetailEvaluateViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//


import Foundation
import RxSwift
import RxCocoa

protocol sendEvaluateFinishDelegate {
    func sendEvaluateFinishAfter(grade: Int)
}

final class MovieDetailEvaluateViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: MovieDetailCoordinator?
    private let contentUseCase: ContentUseCase
    var delegate: sendEvaluateFinishDelegate?
    
    struct Input{
        let backgroundButtonTapped: ControlEvent<Void>
        let goodButtonTapped: ControlEvent<Void>
        let badButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
        let evaluateValid: PublishRelay<Bool>
    }
    
    init(coordinator: MovieDetailCoordinator? = nil, contentUseCase: ContentUseCase, content_id: String) {
        self.coordinator = coordinator
        self.contentUseCase = contentUseCase
        self.contentId = BehaviorRelay(value: content_id)
    }
    
    let evaluateValid = PublishRelay<Bool>()
    var contentId = BehaviorRelay(value: "")
    let gradeChoiceAndModify = PublishRelay<GradeChoiceAndModify>()

    
    func transform(input: Input) -> Output {
        
        Observable.zip(input.backgroundButtonTapped, self.evaluateValid, self.contentId)
            .bind { [weak self] _, valid, contentId in
                guard let self = self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                print(valid, contentId, "찍어보자")
                if valid == nil {
                    print("이거라고?")
                    self.coordinator?.dismissViewController()
                } else  if valid == true {
                    print("맘에들어요")
                    self.psotGradeChoiceAndModify(user_id: user_id, content_id: contentId, content_type: "anime", grade: 1)
                    self.delegate?.sendEvaluateFinishAfter(grade: 1)
                    self.coordinator?.dismissViewController()
                } else {
                    print("맘에안들어요")
                    self.psotGradeChoiceAndModify(user_id: user_id, content_id: contentId, content_type: "anime", grade: -1)
                    self.delegate?.sendEvaluateFinishAfter(grade: -1)
                    self.coordinator?.dismissViewController()
                }
            }
            .disposed(by: disposeBag)
        
        input.goodButtonTapped
            .withUnretained(self)
            .bind { vm, _ in
                print("굳")
                vm.evaluateValid.accept(true)
            }
            .disposed(by: disposeBag)
        
        input.badButtonTapped
            .withUnretained(self)
            .bind { vm, _ in
                print("베드")
                vm.evaluateValid.accept(false)
            }
            .disposed(by: disposeBag)
        
        return Output(evaluateValid: self.evaluateValid)
    }
}

extension MovieDetailEvaluateViewModel {
    private func psotGradeChoiceAndModify(user_id: String, content_id: String, content_type: String, grade: Int) {
        Task {
            let gradeChoiceAndModify = try await contentUseCase.excuteGradeChoiceAndModify(query: GradeChoiceAndModifyQuery(user_id: user_id, contentId: content_id, content_type: content_type, grade: String(grade)))
            print(gradeChoiceAndModify, "평가완료")
            self.gradeChoiceAndModify.accept(gradeChoiceAndModify)
        }
    }
}
