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
    case likeAnimationContent(parameters: LikeAnimationContentQuery)
    case likeMovieContent(parameters: LikeMovieContentQuery)
    case getMyReview(parameters: GetMyReviewQuery)
    case getMyComment(parameters: GetMyCommentQuery)
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
        case .modifyMyProfile:
            return "/my_momentum/mod_profile"
        case .likeAnimationContent:
            return "/my_momentum/like_anime_content"
        case .likeMovieContent:
            return "/my_momentum/like_movie_content"
        case .getMyReview:
            return "/my_momentum/review"
        case .getMyComment:
            return "/my_momentum/comment"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        
        case .myProfile(parameters: let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .modifyMyProfile:
            return nil
        case .likeAnimationContent(parameters: let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .likeMovieContent(parameters: let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .getMyComment(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .getMyReview(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var header: [String : String] {
        switch self {
        case .myProfile, .modifyMyProfile, .likeAnimationContent, .likeMovieContent, .getMyComment, .getMyReview:
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

        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .myProfile, .likeAnimationContent, .likeMovieContent, .getMyReview, .getMyComment:
            return .get
        case .modifyMyProfile:
            return .post
        }
    }
}
