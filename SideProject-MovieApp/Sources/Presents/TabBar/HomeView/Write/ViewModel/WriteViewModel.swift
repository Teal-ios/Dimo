//
//  WriteViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/30.
//

import Foundation
import RxSwift
import RxCocoa

protocol sendPostReviewDelegate {
    func sendPostReview(character_id: Int)
}

final class WriteViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private let characterDetailUseCase: CharacterDetailUseCase
    
    struct Input{
        let cancelButtonTapped: ControlEvent<Void>
        let registerButtonTapped: ControlEvent<Void>
        let spoilerButtonTapped: ControlEvent<Void>
        let reviewText: ControlProperty<String?>
    }
    
    struct Output{
        let spoilerValid: BehaviorSubject<Bool>
        let textValid: BehaviorSubject<Bool>
    }
    
    let postReview = PublishRelay<PostReview>()
    var characterId = BehaviorRelay(value: 0)
    let spoilerValidSubject = BehaviorSubject<Bool>(value: false)
    var delegate: sendPostReviewDelegate?
    
    init(coordinator: TabmanCoordinator? = nil, characterDetailUseCase: CharacterDetailUseCase, characterId: Int) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.characterId = BehaviorRelay(value: characterId)
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

                let characterId = self.characterId.value

                self.postReviewWrite(user_id: UserDefaultManager.userId ?? "", character_id: characterId, review_content: reviewText, review_spoiler: spoilerValid ? 1 : 0)
            }
            .disposed(by: disposeBag)
        
        self.postReview
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vm, postReview in
                vm.delegate?.sendPostReview(character_id: postReview.character_id)
                vm.coordinator?.dismissViewController()
            }
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
            guard let self else { return }
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
        
        return Output(spoilerValid: spoilerValidSubject, textValid: textValidSubject)
    }
}

extension WriteViewModel {
    private func postReviewWrite(user_id: String, character_id: Int, review_content: String, review_spoiler: Int) {
        Task {
            
            let query = PostReviewQuery(user_id: user_id, character_id: character_id, review_content: review_content, review_spoiler: review_spoiler)
            print(query, "글쓸때 보내는 쿼리")
            let postReview = try await characterDetailUseCase.excutePostReview(query: query)
            print(postReview, "리뷰를 작성했습니다")
            self.postReview.accept(postReview)
        }
    }
}
