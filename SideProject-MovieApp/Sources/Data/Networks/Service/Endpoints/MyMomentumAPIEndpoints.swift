//
//  MyMomentumAPIEndpoints.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/22.
//

import Foundation

struct MyMomentumAPIEndpoints {
    static func getMyProfile(with user_id: String) -> MyMomentumRouter<ResponseMyProfileDTO> {
        return MyMomentumRouter<ResponseMyProfileDTO>.myProfile(parameters: MyProfileQuery(user_id: user_id))
    }
    
    static func postModifyMyProfile(with requestDTO: RequestModifyMyProfileDTO) -> MyMomentumRouter<ResponseModifyMyProfileDTO> {
        return MyMomentumRouter<ResponseModifyMyProfileDTO>.modifyMyProfile(parameters: ModifyMyProfileQuery(user_id: requestDTO.user_id, profile_img: requestDTO.profile_img, intro: requestDTO.intro))
    }
    
    static func postModifyMyProfileOnImage(with requestDTO: RequestModifyImageOnProfileDTO) -> MyMomentumRouter<ResponseModifyMyProfileDTO>{
        return MyMomentumRouter<ResponseModifyMyProfileDTO>.modifyMyProfile(parameters: ModifyMyProfileQuery(user_id: requestDTO.user_id, profile_img: requestDTO.profile_img, intro: requestDTO.intro))
    }
    
    static func getLikeAnimationContent(with user_id: String) -> MyMomentumRouter<ResponseLikeAnimationContentDTO> {
        return MyMomentumRouter<ResponseLikeAnimationContentDTO>.likeAnimationContent(parameters: LikeAnimationContentQuery(user_id: user_id))
    }

    static func getLikeMovieContent(with user_id: String) -> MyMomentumRouter<ResponseLikeMovieContentDTO> {
        return MyMomentumRouter<ResponseLikeMovieContentDTO>.likeMovieContent(parameters: LikeMovieContentQuery(user_id: user_id))
    }
    
    static func getMyReview(with user_id: String) -> MyMomentumRouter<ResponseGetMyReviewDTO> {
        return MyMomentumRouter<ResponseGetMyReviewDTO>.getMyReview(parameters: GetMyReviewQuery(user_id: user_id))
    }
    
    static func getMyComment(with user_id: String) -> MyMomentumRouter<ResponseGetMyCommentDTO> {
        return MyMomentumRouter<ResponseGetMyCommentDTO>.getMyComment(parameters: GetMyCommentQuery(user_id: user_id))
    }
    
    static func getMyVotedCharacter(with user_id: String) -> MyMomentumRouter<ResponseGetMyVotedCharacterDTO> {
        return MyMomentumRouter<ResponseGetMyVotedCharacterDTO>.getMyVotedCharacter(parameters: GetMyVotedCharacterQuery(user_id: user_id))
    }
}
