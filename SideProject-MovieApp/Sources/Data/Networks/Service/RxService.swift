//
//  RxService.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/01.
//

import Foundation
import RxSwift

protocol RxService {
    func request<T: Decodable>(target: TargetType, type: T.Type) -> Single<T>
}

final class RxServiceImpl: RxService {
    
    static let shared = RxServiceImpl()
    
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(target: TargetType, type: T.Type) -> Single<T> {
        return Single<T>.create { single in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let task = self.session.dataTask(with: target.request) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(URLError(.unknown)))
                    return
                }
                
                print("📭 Request \(target.request.url!)")
                print("🚩 Response \(httpResponse.statusCode)")
                
                guard let data = data else {
                    single(.failure(NetworkError.internalError))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        single(.success(result))
                    } catch {
                        single(.failure(error))
                    }
                case 400..<500:
                    print("❌ Failure", String(data: data, encoding: .utf8)!)
                    single(.failure(NetworkError.clientError))
                case 500..<599:
                    print("❌ Failure", String(data: data, encoding: .utf8)!)
                    single(.failure(NetworkError.serverError))
                default:
                    print("❌ Failure", String(data: data, encoding: .utf8)!)
                    single(.failure(NetworkError.internalError))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
