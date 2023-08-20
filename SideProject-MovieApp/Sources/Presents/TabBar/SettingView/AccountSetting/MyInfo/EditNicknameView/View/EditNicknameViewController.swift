//
//  EditUserNameViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

final class EditNicknameViewController: BaseViewController {
    
    let editNicknameView = EditNicknameView(title: "닉네임 변경", placeholder: "새로운 닉네임")

    private var viewModel: EditNicknameViewModel

    let viewDidLoadTrigger = PublishRelay<Void>()
    
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
        self.configureToast()
        self.setNicknameLastChangeDate()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.editNicknameView.showCurrentNickname()
    }
    
    private func configureToast() {
        self.viewModel.toast = {
            self.editNicknameView.makeToast("변경을 완료했어요", style: ToastStyle.dimo)
            self.editNicknameView.checkNicknameChangeButton(isValid: false)
            let lastNicknameChangeDate = Date.dateToString(from: self.viewModel.nicknameChangeDate)
            UserDefaultManager.lastNicknameChangeDate = lastNicknameChangeDate ?? ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setNicknameLastChangeDate() {
        if let lastNicknameChangeDate = UserDefaultManager.lastNicknameChangeDate {
            editNicknameView.showLastNicknameChangeDate(date: lastNicknameChangeDate)
        } else {
            let date = Date.dateToString(from: viewModel.nicknameChangeDate)
            editNicknameView.showLastNicknameChangeDate(date: date ?? "")
        }
    }
    
    override func setupBinding() {
        let input = EditNicknameViewModel.Input(
            textFieldEditingDidBegin: editNicknameView.idTextFieldView.tf.rx.controlEvent(.editingDidBegin),
            textFieldEditingChanged: editNicknameView.idTextFieldView.tf.rx.controlEvent(.editingChanged),
            textFieldEditingDidEnd: editNicknameView.idTextFieldView.tf.rx.controlEvent(.editingDidEnd),
            textFieldInput: editNicknameView.idTextFieldView.tf.rx.text,
            nicknameChangeButtonTapped: editNicknameView.nicknameChangeButton.rx.tap,
            viewDidLoad: self.viewDidLoadTrigger
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
                } else {
                    self?.editNicknameView.showEmptyMessage()
                }
            }
            .disposed(by: disposeBag)
        
        output.isTextFieldEditingDidEnd
            .bind { [weak self] isEditingEnd in
                if isEditingEnd {
                    let date = Date.dateToString(from: self?.viewModel.nicknameChangeDate)
                    self?.editNicknameView.showLastNicknameChangeDate(date: date ?? "")
                }
            }
            .disposed(by: disposeBag)
        
        output.isDuplicatedNickname
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isDuplicatedNickname in
                if isDuplicatedNickname {
                    self?.editNicknameView.showDuplicatedNicknameMessage()
                } else {
                    self?.editNicknameView.showValidNicknameMessage()
                    self?.editNicknameView.checkNicknameChangeButton(isValid: true)
                }
            }
            .disposed(by: disposeBag)
        
        output.lastNicknameChangeDate
            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(editNicknameView.idTextFieldView.tf.rx.text)
            .disposed(by: disposeBag)
    }
}
