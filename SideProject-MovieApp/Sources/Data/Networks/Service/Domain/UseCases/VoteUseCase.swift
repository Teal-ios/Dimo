//
//  VoteUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

protocol VoteUseCase {
    func excuteRandomCharacterRecommend(query: RandomCharacterRecommendQuery) async throws -> RandomCharacterRecommendList
    
    func excutePopularCharacterRecommendList(query: PopularCharacterRecommendListQuery) async throws -> PopularCharacterRecommendList
    
    func excuteSearchCharacterList(query: SearchCharacterListQuery) async throws -> SearchCharacterList
    
    func excuteVoteCharacter(query: VoteCharacterQuery) async throws -> VoteCharacter
    
    func excuteSameWorkCharacterList(query: SameWorkCharacterListQuery) async throws -> SameWorkCharacterList
}

enum VoteUseCaseError: String, Error {
    case excute
}

final class VoteUseCaseImpl: VoteUseCase {
    
    private let voteRepository: VoteRepository

    init(voteRepository: VoteRepository) {
        self.voteRepository = voteRepository
    }
}

extension VoteUseCaseImpl {
    func excuteRandomCharacterRecommend(query: RandomCharacterRecommendQuery) async throws -> RandomCharacterRecommendList {
        do {
            return try await voteRepository.fetchRandomCharacterRecommend(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excutePopularCharacterRecommendList(query: PopularCharacterRecommendListQuery) async throws -> PopularCharacterRecommendList {
        do {
            return try await voteRepository.fetchPopularCharacterRecommendList(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}
extension VoteUseCaseImpl {
    func excuteSearchCharacterList(query: SearchCharacterListQuery) async throws -> SearchCharacterList {
        do {
            return try await voteRepository.fetchSearchCharacterList(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteVoteCharacter(query: VoteCharacterQuery) async throws -> VoteCharacter {
        do {
            return try await voteRepository.requestVoteCharacter(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteSameWorkCharacterList(query: SameWorkCharacterListQuery) async throws -> SameWorkCharacterList {
        do {
            return try await voteRepository.fetchSameWorkCharacterList(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}
