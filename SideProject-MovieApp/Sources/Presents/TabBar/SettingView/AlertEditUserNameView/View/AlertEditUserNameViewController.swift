//
//  AlertEditUserNameViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxCocoa
import RxSwift

final class AlertEditUserNameViewController: BaseViewController {
    private let selfView = CustomAlertView(title: "닉네임을 변경할까요?", subtitle: "한 번 설정한 닉네임은 한 달 동안 변경할 수 없습니다.", okButtonTitle: "변경하기")
    private var viewModel: AlertEditUserNameViewModel
    
    init(viewModel: AlertEditUserNameViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        selfView.backgroundColor = .clear
    }
    
    override func setupBinding() {
        let input = AlertEditUserNameViewModel.Input(cancelButtonTapped: selfView.cancelButton.rx.tap, okButtonTapped: selfView.okButton.rx.tap)
        
        let output = viewModel.transform(input: input)
    }
}
