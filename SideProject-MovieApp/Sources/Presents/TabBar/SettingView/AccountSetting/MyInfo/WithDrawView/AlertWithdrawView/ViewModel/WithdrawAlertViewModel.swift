//
//  WithdrawAlertViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/30.
//

import Foundation
import RxSwift
import RxCocoa

final class WithdrawAlertViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: SettingCoordinator?
    private var settingUseCase: SettingUseCase
    
    struct Input {
        var didTappedCancelButton: ControlEvent<Void>
        var didTappedwithdrawButton: ControlEvent<Void>
    }
    
    struct Output {
        var isWithdrawn: PublishRelay<Bool>
    }
    
    private var isWithdrawn: PublishRelay<Bool>
    
    init(coordinator: SettingCoordinator?, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
        self.isWithdrawn = PublishRelay<Bool>()
    }
    
    func transform(input: Input) -> Output {
        input.didTappedCancelButton.bind { [weak self] _ in
            self?.isWithdrawn.accept(false)
        }.disposed(by: disposeBag)
        
        input.didTappedwithdrawButton.bind { [weak self] _ in
            self?.loadWithdraw()
        }
        .disposed(by: disposeBag)

        return Output(isWithdrawn: self.isWithdrawn)
    }
}

extension WithdrawAlertViewModel {
    
    private func loadWithdraw() {
        guard let userId = UserDefaultManager.userId,
              let withdrawReason = self.dissatisfactionReason.value?.withdrawReason else { return }
        let query = WithdrawQuery(userId: userId, withdrawReason: withdrawReason)
        
        Task {
            let withdraw = try await settingUseCase.executeWithdraw(query: query)
            
            if withdraw.code == 200 {
                
            } else {
                
            }
        }
    }
}
