//
//  SignupTermsViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import UIKit
import RxCocoa

class TermsOfUseViewController: BaseViewController {
    
    //MARK: Delegate
    let joinTermsView = JoinTermsView()

    //MARK: Delegate
    private var viewModel: TermsOfUseViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: TermsOfUseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = joinTermsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        print("check")
    }
    override func setupBinding() {
        let input = TermsOfUseViewModel.Input(acceptButtonTapped: joinTermsView.acceptButton.rx.tap, totalAgreedButtonTapped: joinTermsView.totalAgreeButton.rx.tap, ageAgreeButtonTapped: joinTermsView.firstAgreeButton.rx.tap, dimoTermsButtonTapped: joinTermsView.secondAgreeButton.rx.tap, privacyTermsButtonTapped: joinTermsView.thirdAgreeButton.rx.tap, eventPushNotiButtonTapped: joinTermsView.fourAgreeButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        //MARK: Valid 에 따른 NextButton 처리
        output.totalValid
            .bind { [weak self] valid in
                guard let self = self else { return }

                if valid == [true, true, true, true] {
                    self.joinTermsView.acceptButton.configuration?.baseBackgroundColor = .purple100
                    self.joinTermsView.acceptButton.isEnabled = true
                    
                } else if valid == [true, true, true, false] {
                    self.joinTermsView.acceptButton.configuration?.baseBackgroundColor = .purple100
                    self.joinTermsView.acceptButton.isEnabled = true

                } else {
                    self.joinTermsView.acceptButton.configuration?.baseBackgroundColor = .black80
                    self.joinTermsView.acceptButton.isEnabled = false
                }
            }
            .disposed(by: disposeBag)
        
        //MARK: Valid에 따른 각 View 처리
        output.totalValid
            .bind { [weak self] valid in
                guard let self = self else { return }
                if valid == [true, true, true, true] {
                    self.joinTermsView.totalAgreeView.layer.borderColor = UIColor.purple100.cgColor
                    self.joinTermsView.totalAgreeLabel.textColor = .black5
                    self.joinTermsView.totalCheckImageView.image = UIImage(named: "check_purple")

                } else {
                    self.joinTermsView.totalAgreeView.layer.borderColor = UIColor.black80.cgColor
                    self.joinTermsView.totalAgreeLabel.textColor = .black60
                    self.joinTermsView.totalCheckImageView.image = UIImage(named: "check_gray")
                }
                
                if valid[0] == true {
                    self.joinTermsView.firstCheckImageView.image = UIImage(named: "check_purple")
                } else {
                    self.joinTermsView.firstCheckImageView.image = UIImage(named: "check_gray")
                }
                
                if valid[1] == true {
                    self.joinTermsView.secondCheckImageView.image = UIImage(named: "check_purple")
                } else {
                    self.joinTermsView.secondCheckImageView.image = UIImage(named: "check_gray")
                }
                
                if valid[2] == true {
                    self.joinTermsView.thirdCheckImageView.image = UIImage(named: "check_purple")
                } else {
                    self.joinTermsView.thirdCheckImageView.image = UIImage(named: "check_gray")
                }
                
                if valid[3] == true {
                    self.joinTermsView.fourCheckImageView.image = UIImage(named: "check_purple")
                } else {
                    self.joinTermsView.fourCheckImageView.image = UIImage(named: "check_gray")
                }
            }
            .disposed(by: disposeBag)
        
    }
}

