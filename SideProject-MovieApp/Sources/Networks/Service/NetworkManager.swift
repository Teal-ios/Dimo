//
//  NetworkManager.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/15.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    private func makeRequest(_ url: String) throws -> URL {
        guard let url = URL(string: url) else { throw NetworkStatus.invalidURL }
        return url
    }
    
    func request(url: String) async throws -> Data {
        let session = URLSession.shared
        let requestURL = try makeRequest(url)
        let (data, response) = try await session.data(from: requestURL)
        
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
}
