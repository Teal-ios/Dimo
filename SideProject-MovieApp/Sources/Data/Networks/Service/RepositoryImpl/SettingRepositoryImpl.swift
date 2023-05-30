//
//  SettingRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import Combine

final class SettingRepositoryImpl: SettingRepository {
    
    private let session: Service
    
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
}

extension SettingRepositoryImpl {
    func requestDuplicationNickname(query: DuplicationNicknameQuery) -> AnyPublisher<DuplicationNickname, NetworkError> {
        return Future<DuplicationNickname, NetworkError> { promise in
            self.session.request(target: SettingRouter.duplicationNickname(parameters: query), type: ResponseDuplicationNicknameDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { duplicationNicknameDTO in
                let duplicationNickname = duplicationNicknameDTO.toDomain
                promise(.success(duplicationNickname))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}
