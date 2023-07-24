//
//  ContentRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation

enum ContentRouter<R> {
    case inquireAnimationData
    case clickLike
    case cancelLike
    case inquireDetailAnimationData(parameters: String)
}

extension ContentRouter: TargetType2 {
    
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
        case .inquireAnimationData:
            return "/crawling/animedata"
        case .inquireDetailAnimationData(let parameters):
            return "/detail/animedata/\(parameters)"
        case .clickLike:
            return "/detail/like"
        case .cancelLike:
            return "/detail/dislike"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var header: [String : String] {
        switch self {
        case .inquireAnimationData, .clickLike, .cancelLike, .inquireDetailAnimationData:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .inquireDetailAnimationData, .inquireAnimationData:
            return .get
        case .cancelLike, .clickLike:
            return .post
        }
    }
}
