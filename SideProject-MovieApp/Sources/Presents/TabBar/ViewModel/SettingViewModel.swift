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
                print("내 정보 변경")
                self.coordinator?.showEditMyInfoViewController()
            case [0, 1]:
                self.coordinator?.showEditMbtiViewController()
            default:
                print("미설정")
            }
        }
        .disposed(by: disposeBag)
        return Output()
    }
}
