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
        let profileImage: PublishRelay<Data?>
    }
    
    struct Output {
        let editProfileImageButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let editProfileData = Observable.combineLatest(input.introduceText, input.profileImage)
        
        input.okButtonTap
            .withLatestFrom(editProfileData)
            .bind { [weak self] text, image in
                guard let self = self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                if text == nil && image == nil {
                    return
                } else {
                    self.editProfile(user_id: user_id, text: text, imageData: image)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(editProfileImageButtonTap: input.editProfileImageButtonTap)
    }
}

extension EditProfileViewModel {
    private func editProfile(user_id: String, text: String?, imageData: Data?) {
        Task {
            let query = ModifyMyProfileQuery(user_id: user_id, profile_img: imageData, intro: text)
            let editProfile = try await myMomentumUseCase.excuteModifyMyProfile(query: query)
            print(editProfile, "프로필 수정 완료")
        }
    }
}
