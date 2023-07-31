//
//  VoteRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

enum VoteRouter<R> {
    case randomCharacterRecommend(parameters: RandomCharacterRecommendQuery)
    case popularCharacterRecommendList(parameters: PopularCharacterRecommendListQuery)
    case searchCharacterList(parameters: SearchCharacterListQuery)
    case voteCharacter(parameters: VoteCharacterQuery)
    case sameWorkCharacterList(parameters: SameWorkCharacterListQuery)
}

extension VoteRouter: TargetType2 {
    
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
        case .randomCharacterRecommend:
            return "/vote/recommend"
        case .popularCharacterRecommendList:
            return "/vote/recommend"
        case .searchCharacterList:
            return "/vote/search"
        case .voteCharacter:
            return "/vote"
        case .sameWorkCharacterList:
            return "/vote/another_character"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {

        case .randomCharacterRecommend(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "category", value: "rand")]
        case .popularCharacterRecommendList(parameters: let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "category", value: "popular")]
        case .searchCharacterList(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "search_content", value: parameters.search_content)]
        case .voteCharacter:
            return nil
        case .sameWorkCharacterList(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "search_content", value: parameters.search_content)]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var header: [String : String] {
        switch self {
        case .randomCharacterRecommend, .popularCharacterRecommendList, .searchCharacterList, .voteCharacter, .sameWorkCharacterList:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .voteCharacter(let parameters):
            let requestDTO = RequestVoteCharacterDTO(user_id: parameters.user_id, content_id: parameters.content_id, character_id: parameters.character_id, ei: parameters.ei, sn: parameters.sn, tf: parameters.tf, jp: parameters.jp)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)

        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .popularCharacterRecommendList, .randomCharacterRecommend, .sameWorkCharacterList, .searchCharacterList:
            return .get
        case .voteCharacter:
            return .post
        }
    }
}
