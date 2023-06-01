//
//  AuthRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import Combine
import RxSwift

final class AuthRepositoryImpl: AuthRepository {
    
    private let session: RxService
    private var disposeBag = DisposeBag()
    
    init(session: RxService) {
        self.session = session
    }
}

extension AuthRepositoryImpl {
    func requestSignUp(query: SignUpQuery) -> Single<Int> {
        return Single.create { single in
            let disposable = self.session.request(target: AuthRouter.signup(parameters: query), type: StatusCodeResponseDTO.self).subscribe { result in
                switch result {
                case .success(let responseDTO):
                    let response = responseDTO.statusCode
                    single(.success(response ?? 404))
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

extension AuthRepositoryImpl {
    func requestPhoneNumberCheck(query: PhoneNumberCheckQuery) -> Single<PhoneNumberCheck> {
        return Single.create { single in
            let disposable = self.session.request(target: AuthRouter.phoneNumberCheck(parameters: query), type: ResponsePhoneNumberCheckDTO.self).subscribe { result in
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

extension AuthRepositoryImpl {
    func requestPhoneNumberVerify(query: PhoneNumberVerifyQuery) -> Single<PhoneNumberVerify> {
        return Single.create { single in
            let disposable = self.session.request(target: AuthRouter.phoneNumberVerify(parameters: query), type: ResponsePhoneNumberVerifyDTO.self).subscribe { result in
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

extension AuthRepositoryImpl {
    func requestDuplicationId(query: DuplicationIdQuery) -> Single<DuplicationId> {
        return Single.create { single in
            let disposable = self.session.request(target: AuthRouter.duplicationId(parameters: query), type: ResponseDuplicationIdDTO.self).subscribe { result in
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
