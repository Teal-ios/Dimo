//
//  AuthRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxSwift

protocol AuthRepository: AnyObject {
    func requestSignUp(query: SignUpQuery) async throws -> SignUp
    
    func requestPhoneNumberCheck(query: PhoneNumberCheckQuery) async throws -> PhoneNumberCheck
    
    func requestPhoneNumberVerify(query: PhoneNumberVerifyQuery) async throws -> PhoneNumberVerify
    
    func fetchDuplicationId(query: DuplicationIdQuery) async throws -> DuplicationId
}
