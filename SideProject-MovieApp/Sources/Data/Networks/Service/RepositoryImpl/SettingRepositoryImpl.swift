//
//  SettingRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift

final class SettingRepositoryImpl: SettingRepository {
    
    private var disposeBag = DisposeBag()
    private let session: RxService
        
    init(session: RxService) {
        self.session = session
    }
}

extension SettingRepositoryImpl {
    func requestDuplicationNickname(query: NicknameDuplicationQuery) -> Single<DuplicationNickname> {
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
    func requestChangeNickname(query: NicknameChangeQuery) -> Single<ChangeNickname> {
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
