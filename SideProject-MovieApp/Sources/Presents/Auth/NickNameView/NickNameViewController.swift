//
//  NickNameViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/31.
//

import UIKit
import RxCocoa

class NickNameViewController: BaseViewController {
    private let nickNameView = NickNameView(title: "DIMO에서 사용할\n닉네임을 입력해 주세요", placeholder: "닉네임")
    private var viewModel: IDNickNameViewModel
    override func loadView() {
        view = nickNameView
    }
    init(viewModel: IDNickNameViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    override func setupBinding() {
        let input = IDNickNameViewModel.Input(nextButtonTapped: nickNameView.nextButton.rx.tap)
        let _ = viewModel.transform(input: input)
    }
}
