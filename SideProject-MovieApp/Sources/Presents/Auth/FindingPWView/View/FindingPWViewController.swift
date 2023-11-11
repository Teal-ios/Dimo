//
//  FindingPWViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

final class FindPWViewController: BaseViewController {
    //MARK: Delegate
    let findPWView = FindPWView()
    
    private var viewModel: FindPWViewModel
    
    private var isTelecomButtonSelected: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: FindPWViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = findPWView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func setupBinding() {
        let input = FindPWViewModel.Input(phoneNumberInput: findPWView.phoneNumberTextFieldView.tf.rx.text, telecomButtonTapped: findPWView.telecomButton.rx.tap, idInput: findPWView.idTextFieldView.tf.rx.text, nameInput: findPWView.nameTextFieldView.tf.rx.text, nextButtonTapped: findPWView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)

        output.formattedPhoneNumber
            .withUnretained(self)
            .bind { vc, phoneNum in
                vc.findPWView.phoneNumberTextFieldView.tf.text = phoneNum
            }
            .disposed(by: viewModel.disposeBag)
        
        output.isInvalidateUser
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { (vc, isValid) in
                vc.findPWView.makeToast("존재하지 않는 사용자 정보입니다.", style: .dimo)
            }
            .disposed(by: disposeBag)
        
        output.nextButtonValid
            .withUnretained(self)
            .bind { vc, bool in
                vc.findPWView.nextButton.isEnabled = bool
                vc.findPWView.nextButton.configuration?.baseBackgroundColor = bool ? .purple100 : .black80
            }.disposed(by: disposeBag)
        
        output.telecomButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.findPWView.telecomSelectView.isHidden = vc.isTelecomButtonSelected
                vc.isTelecomButtonSelected.toggle()
            }.disposed(by: disposeBag)
        
        for i in findPWView.telecomSelectView.arrangedSubviews {
            guard let button = i as? UIButton? else { break }
            button?.rx.tap
                .withUnretained(self)
                .bind { vc, _ in
                    let agency = button?.titleLabel?.text ?? ""
                    vc.viewModel.set(agency: agency)
                    var attrStr = AttributedString(agency)
                    attrStr.font = .suitFont(ofSize: 16, weight: .Medium)
                    vc.findPWView.telecomButton.configuration?.attributedTitle = attrStr
                    vc.findPWView.telecomButton.configuration?.baseForegroundColor = .white
                    vc.findPWView.telecomSelectView.isHidden = vc.isTelecomButtonSelected
                    vc.isTelecomButtonSelected.toggle()
                }.disposed(by: disposeBag)
        }
    }
    
}
