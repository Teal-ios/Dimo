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
    
    func requestLogin(query: LoginQuery) async throws -> Login
    
    func requestKakaoLogin(query: KakaoLoginQuery) async throws -> KakaoLogin
    
    func requestGoogleLogin(query: GoogleLoginQuery) async throws -> GoogleLogin
    
    func requestAppleLogin(query: AppleLoginQuery) async throws -> AppleLogin
    
    func requestSocial(query: SocialQuery) async throws -> Social
    
    func requestDrop(query: DropQuery) async throws -> Drop
    
    func fetchLogout() async throws -> Logout
    
    func fetchSocialLoginCheck(query: SocialLoginCheckQuery) async throws -> SocialLoginCheck
    
    func fetchUserInfoInSnsLogin(query: UserInfoInSnsLoginQuery) async throws -> UserInfoInSnsLogin
    
    func requestIdFind(query: IdFindQuery) async throws -> IdFind
}
