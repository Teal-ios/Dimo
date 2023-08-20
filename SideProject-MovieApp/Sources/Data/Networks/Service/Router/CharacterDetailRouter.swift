//
//  CharacterDetailRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

enum CharacterDetailRouter<R> {
    case postReview(parameters: PostReviewQuery)
    case getReview(parameters: GetReviewQuery)
    case likeReviewChoice(parameters: LikeReviewChoiceQuery)
    case likeReviewCancel(parameters: LikeReviewCancelQuery)
    case modifyReview(parameters: ModifyReviewQuery)
    case deleteReview(parameters: DeleteReviewQuery)
    case postComment(parameters: PostCommentQuery)
    case getComment(parameters: GetCommentQuery)
    case getReviewDetail(parameters: GetReviewDetailQuery)
}

extension CharacterDetailRouter: TargetType2 {
    
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
        case .postReview:
            return "/character/write_review"
        case .getReview:
            return "/character"
        case .likeReviewChoice:
            return "/character/review_like"
        case .likeReviewCancel:
            return "/character/review_dislike"
        case .modifyReview:
            return "/character/modify_review"
        case .deleteReview:
            return "/character/delete_review"
        case .postComment:
            return "/character/write_comment"
        case .getComment:
            return "/character/comment"
        case .getReviewDetail:
            return "/character/review_detail"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getReview(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "character_id", value: String(parameters.character_id))]
        case .getComment(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "review_id", value: String(parameters.review_id))]
        case .getReviewDetail(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "review_id", value: String(parameters.review_id)), URLQueryItem(name: "character_id", value: String(parameters.character_id))]
        default:
            return nil
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var header: [String : String] {
        switch self {
        default:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .postReview(let parameters):
            let requestDTO = RequestPostReviewDTO(user_id: parameters.user_id, character_id: parameters.character_id, review_content: parameters.review_content, review_spoiler: parameters.review_spoiler)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
        case .likeReviewChoice(let parameters):
            let requestDTO = RequestLikeReviewChoiceDTO(user_id: parameters.user_id, character_id: parameters.character_id, review_id: parameters.review_id)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
        case .likeReviewCancel(let parameters):
            let requestDTO = RequestLikeReviewCancelDTO(user_id: parameters.user_id, character_id: parameters.character_id, review_id: parameters.review_id)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
        case .modifyReview(let parameters):
            let requestDTO = RequestModifyReviewDTO(user_id: parameters.user_id, character_id: parameters.character_id, review_content: parameters.review_content, review_spoiler: parameters.review_spoiler, review_id: parameters.review_id)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
        case .postComment(let parameters):
            let requestDTO = RequestPostCommentDTO(user_id: parameters.user_id, character_id: parameters.character_id, review_id: parameters.review_id, comment_content: parameters.comment_content, comment_spoiler: parameters.comment_spoiler)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
        case .deleteReview(let parameters):
            let requestDTO = RequestDeleteReviewDTO(user_id: parameters.user_id, character_id: parameters.character_id, review_id: parameters.review_id)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getReview, .getComment, .getReviewDetail:
            return .get
        case .postReview, .likeReviewChoice, .likeReviewCancel, .modifyReview,  .postComment:
            return .post
        case .deleteReview:
            return .delete
        }
    }
}
