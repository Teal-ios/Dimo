//
//  NotificationIDViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import UIKit
import RxCocoa
import RxSwift

final class NotificationIDViewController: BaseViewController {
    
    let notificationIDView = NotificationIDView()
    
    private var viewModel: NotificationIDViewModel
    
    private lazy var input = NotificationIDViewModel.Input(pwFindButtonTapped: notificationIDView.passwordFindButton.rx.tap, nextButtonTapped: notificationIDView.nextButton.rx.tap)
    
    init(viewModel: NotificationIDViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = notificationIDView
    }
    
    override func viewDidLoad() {
        self.notificationIDView.setNotificationIDLabelText(userName: viewModel.userName,userId: viewModel.userId)
        super.viewDidLoad()
    }
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        
        let attributedStr = NSMutableAttributedString(string: notificationIDView.notificationIDLabel.text!)
        
        attributedStr.addAttribute(.foregroundColor, value: UIColor.purple80, range: (notificationIDView.notificationIDLabel.text! as NSString).range(of: "\(viewModel.userId)"))
        
        notificationIDView.notificationIDLabel.attributedText = attributedStr
    }
}

