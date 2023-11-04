//
//  EditMyInfoViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxSwift
import RxCocoa

final class EditMyInfoViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: SettingCoordinator?
    private var nicknameChangeDate: Date?
    
    struct Input{
        let cellSelected: PublishSubject<IndexPath>
    }
    
    struct Output{ }
    
    init(coordinator: SettingCoordinator? = nil, nicknameChangeDate: Date?) {
        self.coordinator = coordinator
        self.nicknameChangeDate = nicknameChangeDate
    }
    
    func transform(input: Input) -> Output {
        input.cellSelected.bind { indexPath in
            switch indexPath {
            case [0, 0]:
                self.coordinator?.showEditNicknameViewController(nicknameChangeDate: self.nicknameChangeDate)
            case [0, 1]:
                self.coordinator?.showEditPasswordViewController()
            case [0, 2]:
                UserDefaultManager.removeAllUserDefault()
                self.coordinator?.connectAuthFlow()
                print("로그아웃")
            case [0, 3]:
                self.coordinator?.showWithDrawViewController()
            default:
                print("미설정")
            }
        }
        .disposed(by: disposeBag)
        return Output()
    }
}
