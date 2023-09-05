//
//  ModifyWriteViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import Foundation
import RxSwift
import RxCocoa

protocol sendModifyReviewDelegate {
    func sendModifyReview(text: String)
}

final class ModifyWriteViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private let characterDetailUseCase: CharacterDetailUseCase
    private var review: ReviewList
    
    struct Input{
        let cancelButtonTapped: ControlEvent<Void>
        let registerButtonTapped: ControlEvent<Void>
        let spoilerButtonTapped: ControlEvent<Void>
        let reviewText: ControlProperty<String?>
    }
    
    struct Output{
        let spoilerValid: BehaviorSubject<Bool>
        let textValid: BehaviorSubject<Bool>
        let initText: BehaviorRelay<ReviewList>
    }
    
    let modifyReview = PublishRelay<ModifyReview>()
    let modifyText = PublishRelay<String>()

    let spoilerValidSubject = BehaviorSubject<Bool>(value: false)
    var delegate: sendModifyReviewDelegate?
    
    init(coordinator: TabmanCoordinator? = nil, characterDetailUseCase: CharacterDetailUseCase, review: ReviewList) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.review = review
    }
    
    func transform(input: Input) -> Output {
        input.cancelButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.dismissViewController()
        }
        .disposed(by: disposeBag)

        input.registerButtonTapped
            .debug()
            .flatMapLatest { [weak self] _ -> Observable<String?> in
                guard let self else { return Observable.empty() }
                return input.reviewText.asObservable()
            }
            .compactMap { $0 }
            .bind { [weak self] reviewText in
                guard let self = self else { return }
                guard let spoilerValid = try? self.spoilerValidSubject.value() else { return }

                self.postModifyReview(user_id: UserDefaultManager.userId ?? "", character_id: review.character_id, review_content: reviewText, review_spoiler: spoilerValid ? 1 : 0, review_id: review.review_id)
            }
            .disposed(by: disposeBag)
        
        self.modifyReview
            .withLatestFrom(self.modifyText)
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind(onNext: { vm, text in
                vm.delegate?.sendModifyReview(text: text)
                vm.coordinator?.dismissViewController()
            })
            .disposed(by: disposeBag)
        
        input.spoilerButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            guard var spoilerValid = try? self.spoilerValidSubject.value() else { return }
            if spoilerValid == true {
                spoilerValid = false
            } else {
                spoilerValid = true
            }
            self.spoilerValidSubject.onNext(spoilerValid)
        }
        .disposed(by: disposeBag)
        
        let textValidSubject = BehaviorSubject<Bool>(value: false)
        
        input.reviewText.bind { [weak self] text in
            guard let self = self else { return }
            guard let text = text else { return }
            guard var textValid = try? textValidSubject.value() else { return }
            print(text.count, "text진짜")

            if text != "정대만에 대한 생각을 자유롭게 남겨 주세요" && text.count > 2 {
                textValid = true
            } else {
                textValid = false
            }
            textValidSubject.onNext(textValid)
        }
        .disposed(by: disposeBag)
        
        return Output(spoilerValid: spoilerValidSubject, textValid: textValidSubject, initText: BehaviorRelay(value: self.review))
    }
}

extension ModifyWriteViewModel {
    private func postModifyReview(user_id: String, character_id: Int, review_content: String, review_spoiler: Int, review_id: Int) {
        Task {
            
            let query = ModifyReviewQuery(user_id: user_id, character_id: character_id, review_content: review_content, review_spoiler: review_spoiler, review_id: review_id)
            print(query, "리뷰 수정할 때 보내는 쿼리")
            let modifyReview = try await characterDetailUseCase.excuteModifyReview(query: query)
            print(modifyReview, "리뷰를 수정했습니다.")
            self.modifyText.accept(review_content)
            self.modifyReview.accept(modifyReview)
        }
    }
}
