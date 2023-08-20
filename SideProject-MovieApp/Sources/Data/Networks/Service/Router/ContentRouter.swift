//
//  ContentRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation

enum ContentRouter<R> {
    case inquireAnimationData(parameters: GetAnimationQuery)
    case inquireDetailAnimationData(parameters: String)
    case likeChoice(parameters: LikeChoiceQuery)
    case likeCancel(parameters: LikeCancelQuery)
    case gradeChoiceAndModify(parameters: GradeChoiceAndModifyQuery)
    case likeContentCheck(parameters: LikeContentCheckQuery)
    case getEvalateMbti(parameters: GetEvaluateMbtiQuery)
    case getGradeEvaluate(parameters: GetGradeEvaluateResultQuery)
}

extension ContentRouter: TargetType2 {
    
    typealias Response = R
    
    var header: [String : String] {
        switch self {
        case .inquireAnimationData, .likeCancel, .likeChoice, .inquireDetailAnimationData, .likeContentCheck, .gradeChoiceAndModify, .getEvalateMbti, .getGradeEvaluate:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
        
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
        case .inquireAnimationData:
            return "/home/anime"
        case .inquireDetailAnimationData(let parameters):
            return "/detail/animedata/\(parameters)"
        case .likeChoice:
            return "/detail/like"
        case .likeCancel:
            return "/detail/dislike"
        case .gradeChoiceAndModify:
            return "/detail/grade"
        case .likeContentCheck:
            return "/detail/is_like"
        case .getEvalateMbti:
            return "/detail/mbti_result"
        case .getGradeEvaluate:
            return "/detail/is_grade"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .inquireAnimationData(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .likeContentCheck(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "content_type", value: parameters.content_type), URLQueryItem(name: "contentId", value: parameters.contentId)]
        case .getEvalateMbti(let parameters):
            return [URLQueryItem(name: "contentId", value: parameters.contentId), URLQueryItem(name: "content_type", value: parameters.content_type)]
        case .getGradeEvaluate(let parameters):
            return [URLQueryItem(name: "contentId", value: parameters.contentId), URLQueryItem(name: "content_type", value: parameters.content_type), URLQueryItem(name: "user_id", value: parameters.user_id)]
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .inquireDetailAnimationData, .inquireAnimationData, .likeContentCheck, .getEvalateMbti, .getGradeEvaluate:
            return .get
        case .likeCancel, .likeChoice, .gradeChoiceAndModify:
            return .post
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .likeChoice(let parameters):
            let requestLikeChoiceDTO = RequestLikeChoiceDTO(user_id: parameters.user_id, content_type: parameters.content_type, contentId: parameters.contentId)
            print(requestLikeChoiceDTO)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestLikeChoiceDTO)
            
        case .likeCancel(let parameters):
            let requestLikeCancelDTO = RequestLikeCancelDTO(user_id: parameters.user_id, content_type: parameters.content_type, contentId: parameters.contentId)
            print(requestLikeCancelDTO)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestLikeCancelDTO)
            
        case .gradeChoiceAndModify(let parameters):
            let requestGradeChoiceAndModifyDTO = RequestGradeChoiceAndModifyDTO(user_id: parameters.user_id, contentId: parameters.contentId, content_type: parameters.content_type, grade: parameters.grade)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestGradeChoiceAndModifyDTO)
            
        default:
            return nil
        }
    }
}
