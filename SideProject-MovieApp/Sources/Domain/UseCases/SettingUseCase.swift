//
//  SettingUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import Combine

protocol SettingUseCase {
    func duplicationNicknameExcute(user_id: String, user_nickname: String) -> AnyPublisher<DuplicationNickname, NetworkError>
}

final class SettingUseCaseImpl: SettingUseCase {
    
    let settingRepository: SettingRepository
    private var anyCancellable = Set<AnyCancellable>()

    init(settingRepository: SettingRepository) {
        self.settingRepository = settingRepository
    }
}

extension SettingUseCaseImpl {
    func duplicationNicknameExcute(user_id: String, user_nickname: String) -> AnyPublisher<DuplicationNickname, NetworkError> {
        let duplicationNicknameQuery = DuplicationNicknameQuery(user_id: user_id, user_nickname: user_nickname)
        return Future<DuplicationNickname, NetworkError> { [weak self] promise in
            guard let self else { return }
            print("Query", duplicationNicknameQuery)
            self.settingRepository.requestDuplicationNickname(query: duplicationNicknameQuery).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { duplicationNickname in
                print("응답모델", duplicationNickname)
                promise(.success(duplicationNickname))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}
