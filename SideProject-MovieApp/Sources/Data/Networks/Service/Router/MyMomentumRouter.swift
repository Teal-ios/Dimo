//
//  MyMomentumRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/22.
//

import Foundation

enum MyMomentumRouter<R> {
    case myProfile(parameters: MyProfileQuery)
    case modifyMyProfile(parameters: ModifyMyProfileQuery)
    case modifyImageOnMyProfile(parameters: ModifyImageOnProfileQuery)
    case likeAnimationContent(parameters: LikeAnimationContentQuery)
    case likeMovieContent(parameters: LikeMovieContentQuery)
    case getMyReview(parameters: GetMyReviewQuery)
    case getMyComment(parameters: GetMyCommentQuery)
    case getMyVotedCharacter(parameters: GetMyVotedCharacterQuery)
}

extension MyMomentumRouter: TargetType2 {
    
    typealias Response = R
    
    var port: Int {
        return 3000
    }
    
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return APIKey.baseURL
    }
    
    var path: String {
        switch self {
        case .myProfile:
            return "/my_momentum"
        case .modifyMyProfile, .modifyImageOnMyProfile:
            return "/my_momentum/mod_profile"
        case .likeAnimationContent:
            return "/my_momentum/like_anime_content"
        case .likeMovieContent:
            return "/my_momentum/like_movie_content"
        case .getMyReview:
            return "/my_momentum/review"
        case .getMyComment:
            return "/my_momentum/comment"
        case .getMyVotedCharacter:
            return "/my_momentum/voted_character"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        
        case .myProfile(parameters: let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .modifyMyProfile, .modifyImageOnMyProfile:
            return nil
        case .likeAnimationContent(parameters: let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .likeMovieContent(parameters: let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .getMyComment(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .getMyReview(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .getMyVotedCharacter(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var header: [String : String] {
        switch self {
        case .myProfile, .modifyMyProfile, .likeAnimationContent, .likeMovieContent, .getMyComment, .getMyReview, .getMyVotedCharacter, .modifyImageOnMyProfile:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .modifyMyProfile(parameters: let parameters):
            let requestModifyMyProfileDTO = RequestModifyMyProfileDTO(user_id: parameters.user_id, profile_img: parameters.profile_img, intro: parameters.intro)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try? encoder.encode(requestModifyMyProfileDTO)
        case .modifyImageOnMyProfile(parameters: let parameters):
            let requestModifyImageOnMyProfileDTO = RequestModifyImageOnProfileDTO(user_id: parameters.user_id, profile_img: parameters.profile_img, intro: parameters.intro)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestModifyImageOnMyProfileDTO)
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .myProfile, .likeAnimationContent, .likeMovieContent, .getMyReview, .getMyComment, .getMyVotedCharacter:
            return .get
        case .modifyMyProfile, .modifyImageOnMyProfile:
            return .post
        }
    }
}
