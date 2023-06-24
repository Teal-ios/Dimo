//
//  FindingPWViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import UIKit
import RxCocoa
import RxSwift

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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func setupBinding() {
        let input = FindPWViewModel.Input(phoneNumberInput: findPWView.phoneNumberTextFieldView.tf.rx.text, telecomButtonTapped: findPWView.telecomButton.rx.tap, idInput: findPWView.idTextFieldView.tf.rx.text, nameInput: findPWView.nameTextFieldView.tf.rx.text, nextButtonTapped: findPWView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)

        output.phoneNumberOutput
            .withUnretained(self)
            .bind { vc, str in
                vc.findPWView.phoneNumberTextFieldView.tf.text = vc.viewModel.phoneNumberFormat(phoneNumber: str)
            }.disposed(by: viewModel.disposeBag)
        
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
                    var attrStr = AttributedString(button?.titleLabel?.text ?? "")
                    attrStr.font = .suitFont(ofSize: 16, weight: .Medium)
                    vc.findPWView.telecomButton.configuration?.attributedTitle = attrStr
                    vc.findPWView.telecomButton.configuration?.baseForegroundColor = .white
                    vc.findPWView.telecomSelectView.isHidden = vc.isTelecomButtonSelected
                    vc.isTelecomButtonSelected.toggle()
                }.disposed(by: disposeBag)
        }
    }
    
}
