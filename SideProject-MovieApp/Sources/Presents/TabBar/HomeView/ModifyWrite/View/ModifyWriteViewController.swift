//
//  ModifyWriteViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa

final class ModifyWriteViewController: BaseViewController {
    private let selfView = ModifyWriteView()
    
    private var viewModel: ModifyWriteViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: ModifyWriteViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    var textViewPlaceHolder = "정대만에 대한 생각을 자유롭게 남겨 주세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.reviewTextView.delegate = self
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func setupBinding() {
        
        let input = ModifyWriteViewModel.Input(cancelButtonTapped: self.selfView.cancelButton.rx.tap, registerButtonTapped: self.selfView.registerButton.rx.tap, spoilerButtonTapped: self.selfView.spoilerButton.rx.tap, reviewText: self.selfView.reviewTextView.rx.text)
        
        let output = viewModel.transform(input: input)
        
        output.spoilerValid
            .observe(on: MainScheduler.instance)
            .bind { [weak self] bool in
             guard let self = self else { return }
             self.selfView.updateTextValid(valid: bool)
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
        
        output.initText
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, review in
                vc.selfView.reviewTextView.text = review.review_content
                vc.textViewPlaceHolder = review.review_content
                if review.review_spoiler == 1 {
                    vc.selfView.updateTextValid(valid: true)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension ModifyWriteViewController: UITextViewDelegate {
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
