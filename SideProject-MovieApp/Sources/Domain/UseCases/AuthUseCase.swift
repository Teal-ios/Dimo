//
//  AuthUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxSwift

protocol AuthUseCase {
    func signUpExcute(user_id: String, password: String, name: String, sns_type: String, agency: String, phone_number: String, nickname: String, mbti: String) -> Single<Int>
    
    func phoneNumberCheckExcute(phone_number: String) -> Single<PhoneNumberCheck>
    
    func phoneNumberVerifyExcute(phone_number: String, code: String) -> Single<PhoneNumberVerify>
    
    func duplicationIdExcute(user_id: String) -> Single<DuplicationId>
}

final class AuthUseCaseImpl: AuthUseCase {

    let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
}

extension AuthUseCaseImpl {
    func signUpExcute(user_id: String, password: String, name: String, sns_type: String, agency: String, phone_number: String, nickname: String, mbti: String) -> Single<Int> {
        let query = SignUpQuery(user_id: user_id, password: password, name: name, sns_type: sns_type, agency: agency, phone_number: phone_number, nickname: nickname, mbti: mbti)
        return Single.create { single in
            let disposable = self.authRepository.requestSignUp(query: query).subscribe { result in
                switch result {
                case .success(let statusCode):
                    single(.success(statusCode))
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

extension AuthUseCaseImpl {
    func phoneNumberCheckExcute(phone_number: String) -> Single<PhoneNumberCheck> {
        let query = PhoneNumberCheckQuery(phone_number: phone_number)
        return Single.create { single in
            let disposable = self.authRepository.requestPhoneNumberCheck(query: query).subscribe { result in
                switch result {
                case .success(let data):
                    single(.success(data))
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

extension AuthUseCaseImpl {
    func phoneNumberVerifyExcute(phone_number: String, code: String) -> Single<PhoneNumberVerify> {
        let query = PhoneNumberVerifyQuery(phone_number: phone_number, code: code)
        return Single.create { single in
            let disposable = self.authRepository.requestPhoneNumberVerify(query: query).subscribe { result in
                switch result {
                case .success(let data):
                    single(.success(data))
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

extension AuthUseCaseImpl {
    func duplicationIdExcute(user_id: String) -> Single<DuplicationId> {
        let query = DuplicationIdQuery(user_id: user_id)
        return Single.create { single in
            let disposable = self.authRepository.requestDuplicationId(query: query).subscribe { result in
                switch result {
                case .success(let data):
                    single(.success(data))
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
