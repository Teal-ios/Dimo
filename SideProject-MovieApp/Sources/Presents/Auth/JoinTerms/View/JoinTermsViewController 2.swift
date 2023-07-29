//
//  JoinTermsViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/29.
//

import UIKit
import RxCocoa

class JoinTermsViewController: BaseViewController {
    
    //MARK: Delegate
    let selfView = JoinTermsView()

    //MARK: Delegate
    private var viewModel: JoinTermsViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: JoinTermsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        print("check")
    }
    override func setupBinding() {
        let input = JoinTermsViewModel.Input(acceptButtonTapped: selfView.acceptButton.rx.tap, totalAgreedButtonTapped: selfView.totalAgreeButton.rx.tap, ageAgreeButtonTapped: selfView.firstAgreeButton.rx.tap, dimoTermsButtonTapped: selfView.secondAgreeButton.rx.tap, privacyTermsButtonTapped: selfView.thirdAgreeButton.rx.tap, eventPushNotiButtonTapped: selfView.fourAgreeButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        //MARK: Valid 에 따른 NextButton 처리
        output.totalValid
            .bind { [weak self] valid in
                guard let self = self else { return }

                if valid == [true, true, true, true] {
                    self.selfView.acceptButton.configuration?.baseBackgroundColor = .purple100
                    self.selfView.acceptButton.isEnabled = true
                    
                } else if valid == [true, true, true, false] {
                    self.selfView.acceptButton.configuration?.baseBackgroundColor = .purple100
                    self.selfView.acceptButton.isEnabled = true

                } else {
                    self.selfView.acceptButton.configuration?.baseBackgroundColor = .black80
                    self.selfView.acceptButton.isEnabled = false
                }
            }
            .disposed(by: disposeBag)
        
        //MARK: Valid에 따른 각 View 처리
        output.totalValid
            .bind { [weak self] valid in
                guard let self = self else { return }
                if valid == [true, true, true, true] {
                    self.selfView.totalAgreeView.layer.borderColor = UIColor.purple100.cgColor
                    self.selfView.totalAgreeLabel.textColor = .black5
                    self.selfView.totalCheckImageView.image = UIImage(named: "check_purple")

                } else {
                    self.selfView.totalAgreeView.layer.borderColor = UIColor.black80.cgColor
                    self.selfView.totalAgreeLabel.textColor = .black60
                    self.selfView.totalCheckImageView.image = UIImage(named: "check_gray")
                }
                
                if valid[0] == true {
                    self.selfView.firstCheckImageView.image = UIImage(named: "check_purple")
                } else {
                    self.selfView.firstCheckImageView.image = UIImage(named: "check_gray")
                }
                
                if valid[1] == true {
                    self.selfView.secondCheckImageView.image = UIImage(named: "check_purple")
                } else {
                    self.selfView.secondCheckImageView.image = UIImage(named: "check_gray")
                }
                
                if valid[2] == true {
                    self.selfView.thirdCheckImageView.image = UIImage(named: "check_purple")
                } else {
                    self.selfView.thirdCheckImageView.image = UIImage(named: "check_gray")
                }
                
                if valid[3] == true {
                    self.selfView.fourCheckImageView.image = UIImage(named: "check_purple")
                } else {
                    self.selfView.fourCheckImageView.image = UIImage(named: "check_gray")
                }
            }
            .disposed(by: disposeBag)
        
    }
}

