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
    case inquireVoteResult(parameters: InquireVoteResultQuery)
    case inquireCharacterAnalyze(parameters: InquireCharacterAnalyzeQuery)
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
            return "/vote/search_character"
        case .voteCharacter:
            return "/vote"
        case .sameWorkCharacterList:
            return "/vote/another_character"
        case .inquireVoteResult:
            return "/vote"
        case .inquireCharacterAnalyze:
            return "/vote/view_result"
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
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "character_id", value: String(parameters.character_id))]
        case .inquireVoteResult(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "character_id", value: String(parameters.character_id))]
        case .inquireCharacterAnalyze(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "character_id", value: String(parameters.character_id))]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var header: [String : String] {
        switch self {
        case .randomCharacterRecommend, .popularCharacterRecommendList, .searchCharacterList, .voteCharacter, .sameWorkCharacterList, .inquireCharacterAnalyze, .inquireVoteResult:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .voteCharacter(let parameters):
            let requestDTO = RequestVoteCharacterDTO(user_id: parameters.user_id, contentId: parameters.content_id, character_id: parameters.character_id, ei: parameters.ei, sn: parameters.sn, tf: parameters.tf, jp: parameters.jp)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)

        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .popularCharacterRecommendList, .randomCharacterRecommend, .sameWorkCharacterList, .searchCharacterList, .inquireCharacterAnalyze, .inquireVoteResult:
            return .get
        case .voteCharacter:
            return .post
        }
    }
}
