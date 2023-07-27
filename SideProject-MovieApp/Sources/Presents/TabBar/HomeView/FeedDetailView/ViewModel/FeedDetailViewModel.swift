//
//  FeedDetailViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedDetailViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    
    struct Input{
        let plusNavigationButtonTapped: PublishSubject<Void>
        let spoilerButtonTapped: ControlEvent<Void>
        let commentText: ControlProperty<String?>
    }
    
    struct Output{
        let spoilerValid: BehaviorRelay<Bool>
        let textValid: BehaviorRelay<Bool>
    }
    
    let spoilerValid = BehaviorRelay(value: false)
    let textValid = BehaviorRelay(value: false)
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.plusNavigationButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            self.coordinator?.showFeedDetailMoreMyViewMController()
        }
        .disposed(by: disposeBag)
        
        input.spoilerButtonTapped
            .withUnretained(self)
            .map { [weak self] _ in
                // 여기에 원하는 조건을 추가하여 Bool 값을 변환할 수 있습니다.
                return !(self?.spoilerValid.value ?? false)
            }
            .bind(to: spoilerValid) // 변환한 값을 spoilerValid에 바인딩
            .disposed(by: disposeBag)
        
        input.commentText
            .bind { [weak self] text in
                guard let self else { return }
                if text?.count == 0 {
                    self.textValid.accept(false)
                } else {
                    self.textValid.accept(true)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(spoilerValid: self.spoilerValid, textValid: self.textValid)
    }
}
