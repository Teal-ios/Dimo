//
//  ContentRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation

enum ContentRouter<R> {
    case inquireAnimationData
    case inquireAnimationDetailData(parameters: String)
    case clickLike
    case cancelLike
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
        case .inquireAnimationDetailData:
            return "/detail/animedata"
        case .clickLike:
            return "/detail/like"
        case .cancelLike:
            return "/detail/dislike"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .inquireAnimationDetailData(let parameters):
            return [URLQueryItem(name: "content_Id", value: parameters)]
        default:
            return nil
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var header: [String : String] {
        switch self {
        case .inquireAnimationDetailData, .inquireAnimationData, .clickLike, .cancelLike:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .inquireAnimationDetailData, .inquireAnimationData:
            return .get
        case .cancelLike, .clickLike:
            return .post
        }
    }
}
