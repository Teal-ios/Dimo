//
//  MyMomentumRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/22.
//

import Foundation

protocol MyMomentumRepository: AnyObject {
    
    func fetchMyProfile(query: MyProfileQuery) async throws -> MyProfile
    
    func requestModifyMyProfile(query: ModifyMyProfileQuery) async throws -> ModifyMyProfile
    
    func requestModifyImageOnMyProfile(query: ModifyImageOnProfileQuery) async throws -> ModifyMyProfile
    
    func fetchLikeAnimationContent(query: LikeAnimationContentQuery) async throws -> LikeAnimationContent
    
    func fetchLikeMovieContent(query: LikeMovieContentQuery) async throws -> LikeMovieContent
    
    func fetchMyReview(query: GetMyReviewQuery) async throws -> GetMyReview
    
    func fetchMyComment(query: GetMyCommentQuery) async throws -> GetMyComment
    
    func fetchMyVotedCharacter(query: GetMyVotedCharacterQuery) async throws -> GetMyVotedCharacter
}
