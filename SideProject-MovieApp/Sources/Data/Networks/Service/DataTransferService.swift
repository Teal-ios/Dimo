//
//  DataTransferService.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/06/17.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case decode
}

final class DataTransferService {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func request<T: Decodable, E: TargetType2>(with target: E) async throws -> T where E.Response == T {
        do {
            let responseData = try await networkService.request(target: target)
            let decodedData = try JSONDecoder().decode(T.self, from: responseData)
            return decodedData
        } catch {
            throw DataTransferError.decode
        }
        
    }
}
