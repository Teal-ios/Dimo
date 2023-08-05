//
//  WithDrawViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxSwift
import RxCocoa

final class WithdrawViewController: BaseViewController {
    
    let selfView = WithdrawView()
    
    private var viewModel: WithdrawViewModel
    
    init(viewModel: WithdrawViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("WithDrawViewController: fatal error")
    }
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupBinding() {
        let input = WithdrawViewModel.Input(didTappedContentsDissatisfactionButton: selfView.contentsDissatisfactionView.checkButton.rx.isTapped,
                                            didTappedServiceDissatisfactionButton: selfView.serviceDissatisfactionView.checkButton.rx.isTapped,
                                            didTappedAppDissatisfactionButton: selfView.appDissatisfactionView.checkButton.rx.isTapped,
                                            didTappedLowFrequencyButton: selfView.lowFrequencyView.checkButton.rx.isTapped,
                                            didTappedLosingInterstButton: selfView.losingInterestView.checkButton.rx.isTapped,
                                            didTappedEtcButton: selfView.etcView.checkButton.rx.isTapped,
                                            didBeginEditingTextView: selfView.withdrawalReasonTextView.rx.didBeginEditing,
                                            textViewInput: selfView.withdrawalReasonTextView.rx.text,
                                            didTappedWithdrawButton: selfView.withdrawButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.dissatisfcationReason
            .withUnretained(self)
            .bind { (vc, reason) in
                switch reason {
                case .contentsDissatisfaction(let isSelected):
                    vc.selfView.setupWithdrawReasonButton(reason: .contentsDissatisfaction(isSelected: isSelected))
                case .serviceDissatisfaction(let isSelected):
                    vc.selfView.setupWithdrawReasonButton(reason: .serviceDissatisfaction(isSelected: isSelected))
                case .appDissatisfaction(let isSelected):
                    vc.selfView.setupWithdrawReasonButton(reason: .appDissatisfaction(isSelected: isSelected))
                case .lowFrequency(let isSelected):
                    vc.selfView.setupWithdrawReasonButton(reason: .lowFrequency(isSelected: isSelected))
                case .losingInterest(let isSelected):
                    vc.selfView.setupWithdrawReasonButton(reason: .losingInterest(isSelected: isSelected))
                case .etc(let isSelected):
                    vc.selfView.setupWithdrawReasonButton(reason: .etc(isSelected: isSelected))
                case .none:
                    vc.selfView.enableWithdrawButton(false)
                }
            }
            .disposed(by: disposeBag)
        
        output.didBeginEditingTextView
            .withUnretained(self)
            .bind { (vc, isEditing) in
                vc.selfView.setupTextView(isEditing)
            }
            .disposed(by: disposeBag)
        
        output.textViewTextCountLimit
            .withUnretained(self)
            .bind { (vc, isUnderLimit) in
                if !isUnderLimit {
                    let str = String(vc.selfView.withdrawalReasonTextView.text.prefix(100))
                    vc.selfView.withdrawalReasonTextView.text = str
                }
            }
            .disposed(by: disposeBag)
        
        output.isWithdrawable
            .withUnretained(self)
            .bind { (vc, isWithdrawable) in
                vc.selfView.enableWithdrawButton(isWithdrawable)
            }
            .disposed(by: disposeBag)
    }
}
