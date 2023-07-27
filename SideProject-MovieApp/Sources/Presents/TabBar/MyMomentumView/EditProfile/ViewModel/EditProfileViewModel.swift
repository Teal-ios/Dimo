//
//  EditProfileViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import Foundation
import RxSwift
import RxCocoa

final class EditProfileViewModel: ViewModelType {
    
    private weak var coordinator: MyMomentumCoordinator?
    private let myMomentumUseCase: MyMomentumUseCase
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(coordinator: MyMomentumCoordinator?, myMomentumUseCase: MyMomentumUseCase) {
        self.coordinator = coordinator
        self.myMomentumUseCase = myMomentumUseCase
    }
    
    struct Input {
        let introduceText: ControlProperty<String?>
        let editProfileImageButtonTap: ControlEvent<Void>
        let okButtonTap: ControlEvent<Void>
        let profileImage: PublishRelay<String?>
    }
    
    struct Output {
        let editProfileImageButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(editProfileImageButtonTap: input.editProfileImageButtonTap)
    }
}
