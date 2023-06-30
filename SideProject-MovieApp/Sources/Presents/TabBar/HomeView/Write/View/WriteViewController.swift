//
//  WriteViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/30.
//

import UIKit
import RxCocoa

final class WriteViewController: BaseViewController {
    private let selfView = WriteView()
    
    private var viewModel: WriteViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: WriteViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    let textViewPlaceHolder = "정대만에 대한 생각을 자유롭게 남겨 주세요"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.selfView.reviewTextView.delegate = self
    }
    
    override func setupBinding() {
        
        let input = WriteViewModel.Input(cancelButtonTapped: self.selfView.cancelButton.rx.tap, registerButtonTapped: self.selfView.registerButton.rx.tap, spoilerButtonTapped: self.selfView.spoilerButton.rx.tap, reviewText: self.selfView.reviewTextView.rx.text)
        
        let output = viewModel.transform(input: input)
        
        output.spoilerValid.bind { [weak self] bool in
            guard let self = self else { return }
            if bool == true {
                self.selfView.spoilerCheckImageView.image = UIImage(named: "check_purple")
                self.selfView.totalSpoilerView.layer.borderColor = UIColor.purple100.cgColor
                self.selfView.spoilerLabel.textColor = .black5
            } else {
                self.selfView.spoilerCheckImageView.image = UIImage(named: "check_gray")
                self.selfView.totalSpoilerView.layer.borderColor = UIColor.black80.cgColor
                self.selfView.spoilerLabel.textColor = .black60
            }
        }
        .disposed(by: disposeBag)
        
        output.textValid.bind { [weak self] valid in
            guard let self = self else { return }
            if valid == true {
                self.selfView.registerLabel.textColor = .black40
                self.selfView.registerButton.isEnabled = true
            } else {
                self.selfView.registerLabel.textColor = .black80
                self.selfView.registerButton.isEnabled = false
            }
        }
        .disposed(by: disposeBag)
    }
}

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.selfView.reviewTextView.text == textViewPlaceHolder {
            self.selfView.reviewTextView.text = nil
            self.selfView.reviewTextView.textColor = .black5
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.selfView.reviewTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.selfView.reviewTextView.text = textViewPlaceHolder
            self.selfView.reviewTextView.textColor = .black80
        }
    }
}
