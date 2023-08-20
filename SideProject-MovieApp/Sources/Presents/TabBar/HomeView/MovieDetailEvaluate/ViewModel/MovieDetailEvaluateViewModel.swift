//
//  MovieDetailEvaluateViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//


import Foundation
import RxSwift
import RxCocoa

class MovieDetailEvaluateViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    
    struct Input{
        let backgroundButtonTapped: ControlEvent<Void>
        let goodButtonTapped: ControlEvent<Void>
        let badButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
        let evaluateValid: BehaviorRelay<Bool?>
    }
    
    let evaluateValid = BehaviorRelay<Bool?>(value: nil)
    
    init(coordinator: HomeCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.backgroundButtonTapped.bind { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }
        .disposed(by: disposeBag)
        
        input.backgroundButtonTapped
            .withLatestFrom(self.evaluateValid)
            .bind { [weak self] valid in
                guard let self else { return }
                if valid == nil {
                    self.coordinator?.dismissViewController()
                } else  if valid == true {
                    print("맘에들어요")
                    self.coordinator?.dismissViewController()
                } else {
                    print("맘에안들어요")
                    self.coordinator?.dismissViewController()
                }
            }
            .disposed(by: disposeBag)
        
        input.goodButtonTapped
            .withUnretained(self)
            .bind { vm, _ in
                vm.evaluateValid.accept(true)
            }
            .disposed(by: disposeBag)
        
        input.badButtonTapped
            .withUnretained(self)
            .bind { vm, _ in
                vm.evaluateValid.accept(false)
            }
            .disposed(by: disposeBag)
        
        return Output(evaluateValid: self.evaluateValid)
    }
}
