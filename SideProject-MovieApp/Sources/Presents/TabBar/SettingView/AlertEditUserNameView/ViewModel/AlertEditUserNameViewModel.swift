//
//  AlertEditUserNameViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxSwift
import RxCocoa

final class AlertEditUserNameViewModel: ViewModelType {
    var disposeBag: DisposeBag = DisposeBag()
    
    private weak var coordinator: SettingCoordinator?
    private var settingUseCase: SettingUseCase
    private var newNickname: String?
    
    struct Input {
        var cancelButtonTapped: ControlEvent<Void>
        var okButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        var isNicknameChanged: BehaviorRelay<Bool>
    }
    
    private var isNicknameChanged = BehaviorRelay<Bool>(value: false)
    
    init(coordinator: SettingCoordinator?, settingUseCase: SettingUseCase, newNickname: String?) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
        self.newNickname = newNickname
    }
    
    func transform(input: Input) -> Output {
        input.cancelButtonTapped.bind { [weak self] _ in
            self?.isNicknameChanged.accept(false)
        }.disposed(by: disposeBag)
        
        input.okButtonTapped.bind { [weak self] _ in
            self?.loadNicknameChange(to: self?.newNickname)
        }
        .disposed(by: disposeBag)

        
        return Output(isNicknameChanged: isNicknameChanged)
    }
    
    private func loadNicknameChange(to newNickname: String?) {
        guard let userId = UserDefaults.standard.string(forKey: "userId"),
              let newNickname = newNickname else { return }
        let query = NicknameChangeQuery(user_id: userId, user_nickname: newNickname)
        
        Task { @MainActor () -> Void in
            let nicknameChange = try await settingUseCase.executeNicknameChnage(query: query)
            if nicknameChange.code == 200 {
                self.isNicknameChanged.accept(true)
            } else {
                self.isNicknameChanged.accept(false)
            }
        }
    }
}
