//
//  NetworkService.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/06/15.
//

import Foundation

final class NetworkService {
    
    func request(target: any TargetType2) async throws -> Data {
        do {
            let urlRequest = target.request
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.httpURLResponse}
            
            switch response.statusCode {
            case 200..<300:
                return data
            case 400..<500:
                throw NetworkError.clientError
            case 500..<599:
                throw NetworkError.serverError
            default:
                throw NetworkError.internalError
            }
        } catch {
            throw NetworkError.unexpectedData
        }
    }
}
