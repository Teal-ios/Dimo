//
//  EditProfileViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseStorage

protocol editProfileUpdateDelegate {
    func editProfileFinish(data: ModifyMyProfileQuery)
}

final class EditProfileViewModel: ViewModelType {
    
    private weak var coordinator: MyMomentumCoordinator?
    private let myMomentumUseCase: MyMomentumUseCase
    
    var disposeBag: DisposeBag = DisposeBag()
    var delegate: editProfileUpdateDelegate?
    
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
    
    let editProfileFinish = PublishRelay<ModifyMyProfile>()
    
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
                    if image != nil {
                        self.editProfile(user_id: user_id, text: text, imageData: image, filePath: "\(Date.now)")
                    } else {
                        self.editProfile(user_id: user_id, text: text, imageData: nil, filePath: nil)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        editProfileFinish
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { owner, _ in
                //여기서 화면 뒤로 1초뒤에 보내기
                owner.coordinator?.popViewController()
            }
            .disposed(by: disposeBag)
        
        return Output(editProfileImageButtonTap: input.editProfileImageButtonTap)
    }
}

extension EditProfileViewModel {
    private func editProfile(user_id: String, text: String?, imageData: Data?, filePath: String?) {
        Task {
            
            var query = ModifyMyProfileQuery(user_id: user_id, profile_img: imageData, intro: text)
            if imageData != nil {
                guard let data = imageData else { return }
                query = ModifyMyProfileQuery(user_id: user_id, profile_img: data, intro: text)
            }
            let editProfile = try await myMomentumUseCase.excuteModifyMyProfile(query: query)
            print(editProfile, "프로필 수정 완료")
            self.delegate?.editProfileFinish(data: query)
            self.editProfileFinish.accept(editProfile)
            
            guard let data = imageData else { return }
            guard let path = filePath else { return }
            uploadImage(imageData: data, filePath: "/profile/\(path)")
            
        }
    }
}

extension EditProfileViewModel {
    func uploadImage(imageData: Data, filePath: String) {
        let storage = Storage.storage() //인스턴스 생성
        let metaData = StorageMetadata() //Firebase 저장소에 있는 개체의 메타데이터를 나타내는 클래스, URL, 콘텐츠 유형 및 문제의 개체에 대한 FIRStorage 참조를 검색하는 데 사용
        metaData.contentType = "image/png" //데이터 타입을 image or png 팡이
        storage.reference().child(filePath).putData(imageData, metadata: metaData){
            (metaData,error) in if let error = error { //실패
                print(error)
                return
            }else{ //성공
                print("성공")
            }
        }
    }
}
