//
//  AuthUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import Combine

protocol AuthUseCase {
    func signUpExcute(user_id: String, password: String, name: String, sns_type: String, agency: String, phone_number: String, nickname: String, mbti: String) -> AnyPublisher<Int, NetworkError>
    
    func phoneNumberCheckExcute(phone_number: String) -> AnyPublisher<PhoneNumberCheck, NetworkError>
    
    func phoneNumberVerifyExcute(phone_number: String, code: String) -> AnyPublisher<PhoneNumberVerify, NetworkError>
    
    func duplicationIdExcute(user_id: String) -> AnyPublisher<DuplicationId, NetworkError>
}

final class AuthUseCaseImpl: AuthUseCase {
    let authRepository: AuthRepository
    private var anyCancellable = Set<AnyCancellable>()

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
}

extension AuthUseCaseImpl {
    func signUpExcute(user_id: String, password: String, name: String, sns_type: String, agency: String, phone_number: String, nickname: String, mbti: String) -> AnyPublisher<Int, NetworkError> {
        let signUpQuery = SignUpQuery(user_id: user_id, password: password, name: name, sns_type: sns_type, agency: agency, phone_number: phone_number, nickname: nickname, mbti: mbti)
        return Future<Int, NetworkError> { [weak self] promise in
            guard let self else { return }
            print("서버에게 보내는 Query", signUpQuery)
            self.authRepository.requestSignUp(query: signUpQuery).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { statusCode in
                print("UseCase",statusCode)
                promise(.success(statusCode))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}

extension AuthUseCaseImpl {
    func phoneNumberCheckExcute(phone_number: String) -> AnyPublisher<PhoneNumberCheck, NetworkError> {
        let phoneNumberCheckQuery = PhoneNumberCheckQuery(phone_number: phone_number)
        return Future<PhoneNumberCheck, NetworkError> { [weak self] promise in
            guard let self else { return }
            print("Query", phoneNumberCheckQuery)
            self.authRepository.requestPhoneNumberCheck(query: phoneNumberCheckQuery).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { phoneNumberCheck in
                print("응답모델", phoneNumberCheck)
                promise(.success(phoneNumberCheck))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}

extension AuthUseCaseImpl {
    func phoneNumberVerifyExcute(phone_number: String, code: String) -> AnyPublisher<PhoneNumberVerify, NetworkError> {
        let phoneNumberVerifyQuery = PhoneNumberVerifyQuery(phone_number: phone_number, code: code)
        return Future<PhoneNumberVerify, NetworkError> { [weak self] promise in
            guard let self else { return }
            print("Query", phoneNumberVerifyQuery)
            self.authRepository.requestPhoneNumberVerify(query: phoneNumberVerifyQuery).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { phoneNumberVerify in
                print("응답모델", phoneNumberVerify)
                promise(.success(phoneNumberVerify))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}

extension AuthUseCaseImpl {
    func duplicationIdExcute(user_id: String) -> AnyPublisher<DuplicationId, NetworkError> {
        let duplicationIdQuery = DuplicationIdQuery(user_id: user_id)
        return Future<DuplicationId, NetworkError> { [weak self] promise in
            guard let self else { return }
            print("Query", duplicationIdQuery)
            self.authRepository.requestDuplicationId(query: duplicationIdQuery).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { duplicationId in
                print("응답모델", duplicationId)
                promise(.success(duplicationId))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}

