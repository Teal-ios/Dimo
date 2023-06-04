//
//  AuthRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxSwift

protocol AuthRepository: AnyObject {
    func requestSignUp(query: SignUpQuery) -> Single<Int>
    
    func requestPhoneNumberCheck(query: PhoneNumberCheckQuery) -> Single<PhoneNumberCheck>
    
    func requestPhoneNumberVerify(query: PhoneNumberVerifyQuery) -> Single<PhoneNumberVerify>
    
    func requestDuplicationId(query: DuplicationIdQuery) -> Single<DuplicationId>
}
