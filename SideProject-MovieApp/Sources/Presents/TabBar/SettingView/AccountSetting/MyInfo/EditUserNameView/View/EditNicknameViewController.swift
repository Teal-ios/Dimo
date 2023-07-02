//
//  EditUserNameViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxCocoa
import RxSwift

final class EditNicknameViewController: BaseViewController {
    
    let editNicknameView = EditNicknameView(title: "닉네임 변경", placeholder: "새로운 닉네임")

    private var viewModel: EditNicknameViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: EditNicknameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = editNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        viewModel.loadNicknameChangeDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.editNicknameView.showLastNicknameChangedDate()
    }
    
    override func setupBinding() {
        let input = EditNicknameViewModel.Input(
            textFieldEditingDidBegin: editNicknameView.idTextFieldView.tf.rx.controlEvent(.editingDidBegin),
            textFieldEditingChanged: editNicknameView.idTextFieldView.tf.rx.controlEvent(.editingChanged),
            textFieldEditingDidEnd: editNicknameView.idTextFieldView.tf.rx.controlEvent(.editingDidEnd),
            textFieldInput: editNicknameView.idTextFieldView.tf.rx.text,
            nicknameDuplicationButtonTapped: editNicknameView.duplicationCheckButton.rx.tap,
            nicknameChangeButtonTapped: editNicknameView.nicknameChangeButton.rx.tap,
            viewDidLoad: self.rx.viewDidLoad.asSignal()
        )
        
        let output = viewModel.transform(input: input)
        
        output.isTextFieldEditingDidBegin
            .bind { [weak self] isEditingBegin in
                if isEditingBegin {
                    self?.editNicknameView.showEmptyMessage()
                }
            }
            .disposed(by: disposeBag)
        
        output.isTextFieldChanged
            .bind { [weak self] isEditingChanged in
                self?.editNicknameView.checkNicknameChangeButton(isValid: false)
            }
            .disposed(by: disposeBag)
        
        output.isTextFieldEditingChanged
            .bind { [weak self] isValidFormat in
                if isValidFormat == false {
                    self?.editNicknameView.showUnvalidNicknameFormatMessage()
                    self?.editNicknameView.enableDuplicationCheckButton(isEnabled: false)
                } else {
                    self?.editNicknameView.showEmptyMessage()
                    self?.editNicknameView.enableDuplicationCheckButton(isEnabled: true)
                }
            }
            .disposed(by: disposeBag)
        
        output.isTextFieldEditingDidEnd
            .bind { [weak self] isEditingEnd in
                if isEditingEnd {
                    self?.editNicknameView.showLastNicknameChangedDate()
                }
            }
            .disposed(by: disposeBag)
        
        output.isDuplicatedNickname
            .bind { [weak self] isDuplicatedNickname in
                if isDuplicatedNickname {
                    self?.editNicknameView.showDuplicatedNicknameMessage()
                } else {
                    self?.editNicknameView.showValidNicknameMessage()
                    self?.editNicknameView.checkNicknameChangeButton(isValid: true)
                }
            }
            .disposed(by: disposeBag)
    }
}
