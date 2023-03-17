//
//  NetworkManager.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/15.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    private func makeRequest(_ url: String) throws -> URLRequest {
        
        guard let url = URL(string: url) else { throw NetworkStatus.invalidURL }
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
    
    func request(url: String, httpMethod: HTTPMethod, contentType: String? = nil, parameters: [String : Any]? = nil) async throws -> Data {
        let session = URLSession.shared
        var urlRequest = try makeRequest(url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue(contentType == nil ? HTTPHeaderContentType.Application.json.rawValue : contentType, forHTTPHeaderField: "Content-Type")
        
        if httpMethod.rawValue != HTTPMethod.GET.rawValue {
            let requestBody = encode(parameters: parameters)
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            let status = NetworkStatus.allCases.filter { $0.rawValue == (response as? HTTPURLResponse)?.statusCode }
            if status.count == 1 {
                throw status.first!
            } else { throw NetworkStatus.undefinedERROR }
        }
        
        return data
    }
    
    func decode<T: Decodable>(data: Data, type: T) -> T? {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(T.self, from: data)
            return data
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func encode(parameters: [String : Any]?) -> Data? {
        do {
            guard let parameters else { return nil }
            let requestBody = try JSONSerialization.data(withJSONObject: parameters)
            return requestBody
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
