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

extension VoteRepositoyImpl {
    
    func fetchRecentSearchList(query: RecentSearchListQuery) async throws -> RecentSearchList {
        
        let target = VoteAPIEndpoints.getRecentSearchList(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    
    func fetchRecentCharacterList(query: RecentCharacterListQuery) async throws -> RecentCharacterList {
        
        let target = VoteAPIEndpoints.getRecentCharacterList(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    
    func requestRecentSearchItemSave(query: RecentSearchItemSaveQuery) async throws -> RecentSearchItemSave {
        
        let requestDTO = RequestRecentSearchSaveDTO(user_id: query.user_id, search_content: query.search_content)
        
        let target = VoteAPIEndpoints.postRecentSearchItemSave(with: requestDTO)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    
    func requestRecentCharacterItemSave(query: RecentCharacterItemSaveQuery) async throws -> RecentCharacterItemSave {
        
        let requestDTO = RequestRecentCharacterSaveDTO(user_id: query.user_id, character_id: query.character_id)
        
        let target = VoteAPIEndpoints.postRecentCharacterItemSave(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    
    func deleteRecentSearchItemDelete(query: RecentSearchItemDeleteQuery) async throws -> RecentSearchItemDelete {
        
        let requestDTO = RequestRecentSearchItemDeleteDTO(user_id: query.user_id, search_content: query.search_content)
        
        let target = VoteAPIEndpoints.deleteRecentSearchItemDelete(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    
    func deleteRecentSearchListDelete(query: RecentSearchItemListDeleteQuery) async throws -> RecentSearchItemListDelete {
        
        let requestDTO = RequestRecentSearchListDeleteDTO(user_id: query.user_id)
        
        let target = VoteAPIEndpoints.deleteRecentSearchListDelete(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    
    func deleteRecentCharacterItemDelete(query: RecentCharacterItemDeleteQuery) async throws -> RecentCharacterItemDelete {
        
        let requestDTO = RequestRecentCharacterItemDeleteDTO(user_id: query.user_id, character_id: query.character_id)
        
        let target = VoteAPIEndpoints.deleteRecentCharacterItemDelete(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}

extension VoteRepositoyImpl {
    
    func deleteRecentCharacterListDelete(query: RecentCharacterItemListDeleteQuery) async throws -> RecentCharacterItemListDelete {
        
        let requestDTO = RequestRecentCharacterListDeleteDTO(user_id: query.user_id)
        
        let target = VoteAPIEndpoints.deleteRecentCharacterListDelete(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw VoteRepositoryError.request
        }
    }
}
