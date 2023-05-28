//
//  AuthRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import Combine

final class AuthRepositoryImpl: AuthRepository {
    
    private let session: Service
    
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
}

extension AuthRepositoryImpl {
    func requestSignUp(query: SignUpQuery) -> AnyPublisher<Int, NetworkError> {
        return Future<Int, NetworkError> { promise in
            self.session.statusRequest(target: AuthRouter.signup(parameters: query), type: StatusCodeResponseDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { statusCode in
                print("register",statusCode)
                promise(.success(statusCode))
            }
            .store(in: &self.anyCancellable)
        }.eraseToAnyPublisher()
    }
}

extension AuthRepositoryImpl {
    func requestPhoneNumberCheck(query: PhoneNumberCheckQuery) -> AnyPublisher<PhoneNumberCheck, NetworkError> {
        return Future<PhoneNumberCheck, NetworkError> { promise in
            self.session.request(target: AuthRouter.phoneNumberCheck(parameters: query), type: ResponsePhoneNumberCheckDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { phoneNumberCheckDTO in
                let phoneNumberCheck = phoneNumberCheckDTO.toDomain
                promise(.success(phoneNumberCheck))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}

extension AuthRepositoryImpl {
    func requestPhoneNumberVerify(query: PhoneNumberVerifyQuery) -> AnyPublisher<PhoneNumberVerify, NetworkError> {
        return Future<PhoneNumberVerify, NetworkError> { promise in
            self.session.request(target: AuthRouter.phoneNumberVerify(parameters: query), type: ResponsePhoneNumberVerifyDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { phoneNumberVerifyDTO in
                let phoneNumberVerify = phoneNumberVerifyDTO.toDomain
                promise(.success(phoneNumberVerify))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}

extension AuthRepositoryImpl {
    func requestDuplicationId(query: DuplicationIdQuery) -> AnyPublisher<DuplicationId, NetworkError> {
        return Future<DuplicationId, NetworkError> { promise in
            self.session.request(target: AuthRouter.duplicationId(parameters: query), type: ResponseDuplicationIdDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { duplicationIdDTO in
                let duplicationId = duplicationIdDTO.toDomain
                promise(.success(duplicationId))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}
