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
    
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: SettingCoordinator?
    
    struct Input{
        let cellSelected: PublishSubject<IndexPath>
    }
    
    struct Output{
    }
    
    init(coordinator: SettingCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.cellSelected.bind { indexPath in
            switch indexPath {
            case [0, 0]:
                print("닉네임 변경")
                self.coordinator?.showEditUserNameViewController()
            case [0, 1]:
                print("비밀번호 변경")
                self.coordinator?.showEditPasswordViewController()
                
            default:
                print("미설정")
            }
        }
        .disposed(by: disposebag)
        return Output()
    }
}
