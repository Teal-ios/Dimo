//
//  ContentRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation
import RxSwift

enum ContentRepositoryError: Error {
    case request
}

final class ContentRepositoryImpl: ContentRepository {

    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension ContentRepositoryImpl {
    func fetchAnimationData() async throws -> [AnimationData] {
        do {
            guard let data = MockParser.load() else {
                throw ContentRepositoryError.request
            }
            print(data, "✅✅✅ 그러면 이게 찍히는거네")
            return data
        } catch {
            throw ContentRepositoryError.request
        }
    }
}
