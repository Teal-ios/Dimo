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
    case searchWorkList(parameters: SearchWorkListQuery)
    case voteCharacter(parameters: VoteCharacterQuery)
    case sameWorkCharacterList(parameters: SameWorkCharacterListQuery)
    case inquireVoteResult(parameters: InquireVoteResultQuery)
    case inquireCharacterAnalyze(parameters: InquireCharacterAnalyzeQuery)
    
    case recentSearchList(parameters: RecentSearchListQuery)
    case recentSearchItemSave(parameters: RecentSearchItemSaveQuery)
    case recentSearchItemDelete(parameters: RecentSearchItemDeleteQuery)
    case recentSearchListDelete(parameters: RecentSearchItemListDeleteQuery)
    
    case recentCharacterList(parameters: RecentCharacterListQuery)
    case recentCharacterItemSave(parameters: RecentCharacterItemSaveQuery)
    case recentCharacterItemDelete(parameters: RecentCharacterItemDeleteQuery)
    case recentCharacterListDelete(parameters: RecentCharacterItemListDeleteQuery)
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
        case .searchWorkList:
            return "/vote/search_content"
        case .voteCharacter:
            return "/vote"
        case .sameWorkCharacterList:
            return "/vote/another_character"
        case .inquireVoteResult:
            return "/vote"
        case .inquireCharacterAnalyze:
            return "/vote/view_result"
        case .recentSearchList:
            return "/vote/view_save_search"
        case .recentSearchItemSave:
            return "/vote/save_search"
        case .recentSearchItemDelete:
            return "/vote/delete_search"
        case .recentSearchListDelete:
            return "/vote/delete_all_search"
            
        case .recentCharacterList:
            return "/vote/view_recent_seen_chr"
        case .recentCharacterItemSave:
            return "/vote/save_chr_list"
        case .recentCharacterItemDelete:
            return "/vote/delete_seen_chr"
        case .recentCharacterListDelete:
            return "/vote/delete_all_seen_chr"
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
        case .searchWorkList(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "search_content", value: parameters.search_content)]
        case .voteCharacter:
            return nil
        case .sameWorkCharacterList(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "character_id", value: String(parameters.character_id))]
        case .inquireVoteResult(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "character_id", value: String(parameters.character_id))]
        case .inquireCharacterAnalyze(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "character_id", value: String(parameters.character_id))]
        case .recentSearchList(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .recentCharacterList(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        default:
            return nil
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var header: [String : String] {
        switch self {
        case
                .randomCharacterRecommend,
                .popularCharacterRecommendList,
                .searchCharacterList,
                .voteCharacter,
                .sameWorkCharacterList,
                .inquireCharacterAnalyze,
                .inquireVoteResult,
                .searchWorkList,
                .recentSearchList,
                .recentSearchItemSave,
                .recentSearchItemDelete,
                .recentSearchListDelete,
                .recentCharacterList,
                .recentCharacterItemSave,
                .recentCharacterItemDelete,
                .recentCharacterListDelete:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .voteCharacter(let parameters):
            let requestDTO = RequestVoteCharacterDTO(user_id: parameters.user_id, contentId: parameters.content_id, character_id: parameters.character_id, ei: parameters.ei, sn: parameters.sn, tf: parameters.tf, jp: parameters.jp)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
            
        case .recentSearchItemSave(let parameters):
            let requestDTO = RequestRecentSearchSaveDTO(user_id: parameters.user_id, search_content: parameters.user_id)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
            
        case .recentSearchItemDelete(let parameters):
            let requestDTO = RequestRecentSearchItemDeleteDTO(user_id: parameters.user_id, search_content: parameters.search_content)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
            
        case .recentSearchListDelete(let parameters):
            let requestDTO = RequestRecentSearchListDeleteDTO(user_id: parameters.user_id)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
            
        case .recentCharacterItemSave(let parameters):
            let requestDTO = RequestRecentCharacterSaveDTO(user_id: parameters.user_id, character_id: parameters.character_id)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
            
        case .recentCharacterItemDelete(let parameters):
            let requestDTO = RequestRecentCharacterItemDeleteDTO(user_id: parameters.user_id, character_id: parameters.character_id)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
            
        case .recentCharacterListDelete(let parameters):
            let requestDTO = RequestRecentCharacterListDeleteDTO(user_id: parameters.user_id)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
            
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .popularCharacterRecommendList, .randomCharacterRecommend, .sameWorkCharacterList, .searchCharacterList, .inquireCharacterAnalyze, .inquireVoteResult, .searchWorkList, .recentSearchList, .recentCharacterList:
            return .get
        case
                .recentSearchItemDelete,
                .recentSearchListDelete,
                .recentCharacterItemDelete,
                .recentCharacterListDelete:
            return .delete
            
        case
                .voteCharacter,
                .recentCharacterItemSave,
                .recentSearchItemSave:
            return .post
        }
    }
}
