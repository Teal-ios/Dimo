//
//  WriteViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/30.
//

import Foundation
import RxSwift
import RxCocoa

final class WriteViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    
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
    
    
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.cancelButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.dismissViewController()
        }
        .disposed(by: disposeBag)
        
        input.registerButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.dismissViewController()
        }
        .disposed(by: disposeBag)
        
        let spoilerValidSubject = BehaviorSubject<Bool>(value: false)
        
        input.spoilerButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            guard var spoilerValid = try? spoilerValidSubject.value() else { return }
            if spoilerValid == true {
                spoilerValid = false
            } else {
                spoilerValid = true
            }
            spoilerValidSubject.onNext(spoilerValid)
        }
        .disposed(by: disposeBag)
        
        let textValidSubject = BehaviorSubject<Bool>(value: false)
        
        input.reviewText.bind { [weak self] text in
            guard let text = text else { return }
            guard var textValid = try? textValidSubject.value() else { return }

            if text != "정대만에 대한 생각을 자유롭게 남겨 주세요" && text.count != 0 {
                textValid = true
            }
            textValidSubject.onNext(textValid)
        }
        .disposed(by: disposeBag)
        
        return Output(spoilerValid: spoilerValidSubject, textValid: textValidSubject)
    }
}
