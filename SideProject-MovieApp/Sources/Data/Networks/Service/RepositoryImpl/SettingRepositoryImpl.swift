//
//  SettingRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift

final class SettingRepositoryImpl: SettingRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension SettingRepositoryImpl {
    
    func requestDuplicationNickname(query: NicknameDuplicationQuery) -> NicknameDuplication {
        let requestDTO = NicknameDuplicationRequestDTO(user_id: query.user_id, user_nickname: query.user_nickname)
        let target = APIEnd
        
        
        
        
        
        return Single.create { single in
            let disposable = self.session.request(target: SettingRouter.duplicationNickname(parameters: query), type: ResponseDuplicationNicknameDTO.self).subscribe { result in
                switch result {
                case .success(let responseDTO):
                    let response = responseDTO.toDomain
                    single(.success(response))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}

extension SettingRepositoryImpl {
    func requestChangeNickname(query: NicknameChangeQuery) -> NicknameChange {
        return Single.create { single in
            let disposable = self.session.request(target: SettingRouter.changeNickname(parameters: query), type: ResponseChangeNicknameDTO.self).subscribe { result in
                switch result {
                case .success(let responseDTO):
                    let response = responseDTO.toDomain
                    single(.success(response))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
