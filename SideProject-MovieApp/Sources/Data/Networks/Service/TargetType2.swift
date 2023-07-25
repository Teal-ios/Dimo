//
//  TargetType2.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/06/19.
//

import Foundation

protocol TargetType2 {
    associatedtype Response
    
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var header: [String: String] { get }
    var parameters: String? { get }
    var port: Int { get }
    var body: Data? { get }
}

extension TargetType2 {
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        components.port = port
        return components
    }
    
    var request: URLRequest {
        guard let url = components.url else { fatalError("URL ERRROR") }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = header
        request.httpBody = parameters?.data(using: .utf8)
        request.httpBody = body
        let decoder = JSONDecoder()
        return request
    }
}
