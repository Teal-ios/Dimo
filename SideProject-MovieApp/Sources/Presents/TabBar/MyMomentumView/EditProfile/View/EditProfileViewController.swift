//
//  EditProfileViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import UIKit
import RxCocoa
import RxSwift

final class EditProfileViewController: BaseViewController {
    private let selfView = EditProfileView()
    
    private let viewModel: EditProfileViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("EditProfileViewController: fatal error")
    }
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    let profileImage = PublishRelay<String?>()
    
    let textViewPlaceHolder = "자기소개를 입력해 보세요"
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        self.selfView.introduceEditTextView.delegate = self
    }
    
    override func setupBinding() {
        let input = EditProfileViewModel.Input(introduceText: self.selfView.introduceEditTextView.rx.text, editProfileImageButtonTap: self.selfView.profileImageEditButton.rx.tap, okButtonTap: self.selfView.okButton.rx.tap, profileImage: self.profileImage)
        
        let output = viewModel.transform(input: input)
        
        output.editProfileImageButtonTap
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                guard let self else { return }
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                self.present(imagePicker, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
}

extension EditProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.selfView.introduceEditTextView.text == textViewPlaceHolder {
            self.selfView.introduceEditTextView.text = nil
            self.selfView.introduceEditTextView.textColor = .black5
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.selfView.introduceEditTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.selfView.introduceEditTextView.text = textViewPlaceHolder
            self.selfView.introduceEditTextView.textColor = .black80
        }
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.selfView.updateProfileImage(image: pickedImage)
            
            if let data = pickedImage.jpegData(compressionQuality: 1) {
                let base64 = data.base64EncodedString()
                self.profileImage.accept(base64)
            }
        }
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
