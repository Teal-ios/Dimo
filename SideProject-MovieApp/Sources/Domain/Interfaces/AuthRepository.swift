//
//  AuthRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import Combine

protocol AuthRepository: AnyObject {
    func requestSignUp(query: SignUpQuery) -> AnyPublisher<Int, NetworkError>
    
    func requestPhoneNumberCheck(query: PhoneNumberCheckQuery) -> AnyPublisher<PhoneNumberCheck, NetworkError>
    
    func requestPhoneNumberVerify(query: PhoneNumberVerifyQuery) -> AnyPublisher<PhoneNumberVerify, NetworkError>
    
    func requestDuplicationId(query: DuplicationIdQuery) -> AnyPublisher<DuplicationId, NetworkError>
}
