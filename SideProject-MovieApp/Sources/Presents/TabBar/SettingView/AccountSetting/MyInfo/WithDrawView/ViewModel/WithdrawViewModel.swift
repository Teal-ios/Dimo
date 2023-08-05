//
//  WithDrawViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//


import Foundation
import RxCocoa
import RxSwift

class WithdrawViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: SettingCoordinator?
    private var settingUseCase: SettingUseCase
    
    enum WithdrawReason: Equatable {
        case contentsDissatisfaction(isSelected: Bool)
        case serviceDissatisfaction(isSelected: Bool)
        case appDissatisfaction(isSelected: Bool)
        case lowFrequency(isSelected: Bool)
        case losingInterest(isSelected: Bool)
        case etc(isSelected: Bool)
        
        var withdrawReason: String {
            switch self {
            case .contentsDissatisfaction: return "콘텐츠 불만족"
            case .serviceDissatisfaction: return "서비스 불만족"
            case .appDissatisfaction: return "앱 불만족"
            case .lowFrequency: return "사용 빈도 낮음"
            case .losingInterest: return "단순 흥미 하락"
            case .etc: return "기타"
            }
        }
    }
    
    struct Input {
        let didTappedContentsDissatisfactionButton: ControlProperty<Bool>
        let didTappedServiceDissatisfactionButton: ControlProperty<Bool>
        let didTappedAppDissatisfactionButton: ControlProperty<Bool>
        let didTappedLowFrequencyButton: ControlProperty<Bool>
        let didTappedLosingInterstButton: ControlProperty<Bool>
        let didTappedEtcButton: ControlProperty<Bool>
        let didBeginEditingTextView: ControlEvent<Void>
        let textViewInput: ControlProperty<String?>
        let didTappedWithdrawButton: ControlEvent<Void>
    }
    
    private var dissatisfactionReason = BehaviorRelay<WithdrawReason?>(value: nil)
    private var withdrawReasonTextView = BehaviorRelay<String?>(value: nil)
    private var didBeginEditingTextView = BehaviorRelay(value: false)
    
    struct Output {
        let dissatisfcationReason: BehaviorRelay<WithdrawReason?>
        let didBeginEditingTextView: BehaviorRelay<Bool>
        let textViewTextCountLimit: Observable<Bool>
        let isWithdrawable: Observable<Bool>
    }
    
    init(coordinator: SettingCoordinator, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(input: Input) -> Output {
        
        input.didTappedContentsDissatisfactionButton
            .withUnretained(self)
            .bind { (vm, isTapped) in
                vm.dissatisfactionReason.accept(.contentsDissatisfaction(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedServiceDissatisfactionButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.dissatisfactionReason.accept(.serviceDissatisfaction(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedAppDissatisfactionButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.dissatisfactionReason.accept(.appDissatisfaction(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedLowFrequencyButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.dissatisfactionReason.accept(.lowFrequency(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedLosingInterstButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.dissatisfactionReason.accept(.losingInterest(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedEtcButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.dissatisfactionReason.accept(.etc(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didBeginEditingTextView
            .withUnretained(self)
            .bind { (vc, _) in
                self.didBeginEditingTextView.accept(true)
            }
            .disposed(by: disposeBag)
                      
        
        let textViewTextCountLimit =  input.textViewInput.orEmpty
            .map { $0.count <= 100 }
            .share()
                      
        input.textViewInput
            .withUnretained(self)
            .bind { (vc, text) in
                self.withdrawReasonTextView.accept(text)
            }
            .disposed(by: disposeBag)
        
        let isWithdrawable = self.dissatisfactionReason
            .map { $0 == WithdrawReason.contentsDissatisfaction(isSelected: true) ||
                    $0 == WithdrawReason.serviceDissatisfaction(isSelected: true) ||
                    $0 == WithdrawReason.appDissatisfaction(isSelected: true) ||
                    $0 == WithdrawReason.lowFrequency(isSelected: true) ||
                    $0 == WithdrawReason.losingInterest(isSelected: true) ||
                    $0 == WithdrawReason.etc(isSelected: true) }
            .share()
        
        input.didTappedWithdrawButton
            .withUnretained(self)
            .bind { (vm, _) in
                guard let withdrawReason = vm.dissatisfactionReason.value?.withdrawReason else { return }
                let withdrawReasonTextViewText = "\n 탈퇴사유: \(vm.withdrawReasonTextView.value ?? "")"
                vm.coordinator?.showAlertWithdrawViewController(with: withdrawReason + withdrawReasonTextViewText)
            }
            .disposed(by: disposeBag)
                    
        return Output(dissatisfcationReason: self.dissatisfactionReason,
                      didBeginEditingTextView: self.didBeginEditingTextView,
                      textViewTextCountLimit: textViewTextCountLimit,
                      isWithdrawable: isWithdrawable)
    }
}

extension WithdrawViewModel {
    
    private func loadWithdraw() {
        guard let userId = UserDefaultManager.userId,
              let withdrawReason = self.dissatisfactionReason.value?.withdrawReason else { return }
        let query = WithdrawQuery(userId: userId, withdrawReason: withdrawReason)
        
//        Task {
//            let withdraw = try await settingUseCase.executeWithdraw(query: query)
//
//            if withdraw.code == 200 {
//
//            } else {
//
//            }
//        }
    }
}
