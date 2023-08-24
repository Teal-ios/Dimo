//
//  VoteRepositoyImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

enum VoteRepositoryError: Error {
    case request
}

final class VoteRepositoyImpl: VoteRepository {

    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension VoteRepositoyImpl {
    func fetchRandomCharacterRecommend(query: RandomCharacterRecommendQuery) async throws -> RandomCharacterRecommendList {
        let target = VoteAPIEndpoints.getRandomCharacterRecommend(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    func fetchPopularCharacterRecommendList(query: PopularCharacterRecommendListQuery) async throws -> PopularCharacterRecommendList {
        let target = VoteAPIEndpoints.getPopularCharacterRecommend(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    func fetchSearchCharacterList(query: SearchCharacterListQuery) async throws -> SearchCharacterList {
        let target = VoteAPIEndpoints.getSearchCharacterList(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    func fetchSearchWorkList(query: SearchWorkListQuery) async throws -> SearchWorkList {
        let target = VoteAPIEndpoints.getSearchWorkList(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    func requestVoteCharacter(query: VoteCharacterQuery) async throws -> VoteCharacter {
        let requestDTO = RequestVoteCharacterDTO(user_id: query.user_id, contentId: query.content_id, character_id: query.character_id, ei: query.ei, sn: query.sn, tf: query.tf, jp: query.jp)
        let target = VoteAPIEndpoints.postVoteCharacter(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}
extension VoteRepositoyImpl {
    func fetchSameWorkCharacterList(query: SameWorkCharacterListQuery) async throws -> SameWorkCharacterList {
        let target = VoteAPIEndpoints.getSameCharacterList(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    func fetchInquireVoteResult(query: InquireVoteResultQuery) async throws -> InquireVoteResult {
        let target = VoteAPIEndpoints.getInquireVoteResult(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    func fetchInquireCharacterAnalyze(query: InquireCharacterAnalyzeQuery) async throws -> InquireCharacterAnalyze {
        let target = VoteAPIEndpoints.getInquireCharacterAnalyze(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}
