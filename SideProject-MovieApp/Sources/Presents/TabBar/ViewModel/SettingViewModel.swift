//
//  SettingViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: SettingCoordinator?
    private var settingUseCase: SettingUseCase
    private var nickname: String?
    private var mbti: String?
    private var nicknameChangeDate: Date?
    private var mbtiChangeDate: Date?
    
    struct Input {
        let cellSelected: PublishSubject<IndexPath>
    }
    
    struct Output {
    }
    
    init(coordinator: SettingCoordinator? = nil, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(input: Input) -> Output {
        input.cellSelected.bind { indexPath in
            switch indexPath {
            case [0, 0]:
                print("내 정보 변경")
                self.coordinator?.showEditMyInfoViewController(nicknameChangeDate: self.nicknameChangeDate)
            case [0, 1]:
                self.coordinator?.showEditMbtiViewController(mbti: self.mbti, mbtiChangeDate: self.mbtiChangeDate)
            case [1, 0]:
                self.coordinator?.showPushNotificationSettingViewController()
            case [1, 1]:
                self.coordinator?.showKeywordNotificationViewController()
            case [2, 0]:
                self.coordinator?.showNoticeViewController()
            case [2, 1]:
                self.coordinator?.showFrequentQuestionViewController()
            case [2, 3]:
                self.coordinator?.showCharacterAskViewController()
            default:
                print("미설정")
            }
        }
        .disposed(by: disposeBag)
        
        return Output()
    }
}

extension SettingViewModel {
    
    func loadUserInfo() {
        Task {
            guard let userId = UserDefaultManager.userId else { return }
            
            let userInfo = try await settingUseCase.executeUserInfo(query: UserInfoQuery(user_id: userId))
            
            print("USER INFO: ", userInfo)
            
            if userInfo.code == 200 {
                self.nickname = userInfo.nickname
                self.mbti = userInfo.mbti
                self.nicknameChangeDate = userInfo.nicknameUpdateDate
                self.mbtiChangeDate = userInfo.mbtiUpdateDate
                print("🔥 MBTI: \(userInfo.mbti)")
                print("🔥 MBTI CHANGE DATE: \(userInfo.mbtiUpdateDate)")
            }
        }
    }
}
