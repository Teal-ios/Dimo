//
//  EditNotificationViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/04.
//

import UIKit
import RxSwift
import RxCocoa

final class PushNotificationSettingViewController: BaseViewController {
    
    private let pushNotificationSettingView = PushNotificationSettingView()
    
    private let viewModel: PushNotificationSettingViewModel
    
    private lazy var input = PushNotificationSettingViewModel.Input(didTappedAllNotificationSwitch: pushNotificationSettingView.allNotificationSwitch.rx.isOn,
                                                                    didTappedReplyNotificationSwitch: pushNotificationSettingView.replyNotificationSwitch.rx.isOn,
                                                                    didTappedKeywordNotificationSwitch: pushNotificationSettingView.keywordNotificationSwitch.rx.isOn,
                                                                    didTappedDimoNewsNotificationSwitch: pushNotificationSettingView.dimoNewsNotificationSwitch.rx.isOn)
    
    init(viewModel: PushNotificationSettingViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        self.view = pushNotificationSettingView
    }
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
        output.isTappedAllNotificationSwitch
            .withUnretained(self)
            .bind { (vc, isOn) in
                vc.pushNotificationSettingView.didTappedAllNotificaionSwitch(isOn)
            }
            .disposed(by: disposeBag)
        
        output.isTappedReplyNotificationSwitch
            .withUnretained(self)
            .bind { (vc, isOn) in
                vc.pushNotificationSettingView.didTappedReplyNotificationSwitch(isOn)
                
                if vc.pushNotificationSettingView.replyNotificationSwitch.isOn &&
                    vc.pushNotificationSettingView.keywordNotificationSwitch.isOn &&
                    vc.pushNotificationSettingView.dimoNewsNotificationSwitch.isOn {
                    vc.pushNotificationSettingView.turnOnAllNotificationSwitch()
                }
            }
            .disposed(by: disposeBag)
        
        output.isTappedKeywordNotificationSwitch
            .withUnretained(self)
            .bind { (vc, isOn) in
                vc.pushNotificationSettingView.didTappedKeywordNotificationSwitch(isOn)
                
                if vc.pushNotificationSettingView.replyNotificationSwitch.isOn &&
                    vc.pushNotificationSettingView.keywordNotificationSwitch.isOn &&
                    vc.pushNotificationSettingView.dimoNewsNotificationSwitch.isOn {
                    vc.pushNotificationSettingView.turnOnAllNotificationSwitch()
                }
            }
            .disposed(by: disposeBag)
        
        output.isTappedDimoNewsNotificationSwitch
            .withUnretained(self)
            .bind { (vc, isOn) in
                vc.pushNotificationSettingView.didTappedDimoNewsNotificationSwitch(isOn)
                
                if vc.pushNotificationSettingView.replyNotificationSwitch.isOn &&
                    vc.pushNotificationSettingView.keywordNotificationSwitch.isOn &&
                    vc.pushNotificationSettingView.dimoNewsNotificationSwitch.isOn {
                    vc.pushNotificationSettingView.turnOnAllNotificationSwitch()
                }
            }
            .disposed(by: disposeBag)
    }
}
