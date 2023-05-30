//
//  AsyncAwaitService.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

protocol AsyncAwaitService {
    func request<T: Decodable>(target: TargetType, type: T.Type) async throws -> T
}

final class AsyncAwaitServiceImpl: AsyncAwaitService {
    
    static let shared = AsyncAwaitServiceImpl()
    
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(target: TargetType, type: T.Type) async throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let (data, response) = try await session.data(for: target.request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.unknown)
        }
        
        print("📭 Request \(target.request.url!)")
        print("🚩 Response \(httpResponse.statusCode)")
        
        switch httpResponse.statusCode {
        case 200..<300:
            print("✅ Success", String(data: data, encoding: .utf8)!)
            return try decoder.decode(T.self, from: data)
        case 400..<500:
            print("❌ Failure", String(data: data, encoding: .utf8)!)
            throw NetworkError.clientError
        case 500..<599:
            print("❌ Failure", String(data: data, encoding: .utf8)!)
            throw NetworkError.serverError
        default:
            print("❌ Failure", String(data: data, encoding: .utf8)!)
            throw NetworkError.internalError
        }
    }
}
