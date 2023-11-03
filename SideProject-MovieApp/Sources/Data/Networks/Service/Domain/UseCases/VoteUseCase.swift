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
    
    func excuteSearchWorkList(query: SearchWorkListQuery) async throws -> SearchWorkList
    
    func excuteVoteCharacter(query: VoteCharacterQuery) async throws -> VoteCharacter
    
    func excuteSameWorkCharacterList(query: SameWorkCharacterListQuery) async throws -> SameWorkCharacterList
    
    func excuteInquireVoteResult(query: InquireVoteResultQuery) async throws -> InquireVoteResult
    
    func excuteInquireCharacterAnalyze(query: InquireCharacterAnalyzeQuery) async throws -> InquireCharacterAnalyze
    
    func excuteRecentSearchList(query: RecentSearchListQuery) async throws -> RecentSearchList
    
    func excuteRecentCharacterList(query: RecentCharacterListQuery) async throws -> RecentCharacterList
    
    func excuteRecentSearchItemSave(query: RecentSearchItemSaveQuery) async throws -> RecentSearchItemSave
    
    func excuteRecentCharacterItemSave(query: RecentCharacterItemSaveQuery) async throws -> RecentCharacterItemSave
    
    func excuteRecentSearchItemDelete(query: RecentSearchItemDeleteQuery) async throws -> RecentSearchItemDelete
    
    func excuteRecentSearchListDelete(query: RecentSearchItemListDeleteQuery) async throws -> RecentSearchItemListDelete
    
    func excuteRecentCharacterItemDelete(query: RecentCharacterItemDeleteQuery) async throws -> RecentCharacterItemDelete
    
    func excuteRecentCharacterListDelete(query: RecentCharacterItemListDeleteQuery) async throws -> RecentCharacterItemListDelete
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
    func excuteSearchWorkList(query: SearchWorkListQuery) async throws -> SearchWorkList {
        do {
            return try await voteRepository.fetchSearchWorkList(query: query)
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

extension VoteUseCaseImpl {
    func excuteInquireVoteResult(query: InquireVoteResultQuery) async throws -> InquireVoteResult {
        do {
            return try await voteRepository.fetchInquireVoteResult(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteInquireCharacterAnalyze(query: InquireCharacterAnalyzeQuery) async throws -> InquireCharacterAnalyze {
        do {
            return try await voteRepository.fetchInquireCharacterAnalyze(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteRecentSearchList(query: RecentSearchListQuery) async throws -> RecentSearchList {
        do {
            return try await voteRepository.fetchRecentSearchList(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteRecentCharacterList(query: RecentCharacterListQuery) async throws -> RecentCharacterList {
        do {
            return try await voteRepository.fetchRecentCharacterList(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteRecentSearchItemSave(query: RecentSearchItemSaveQuery) async throws -> RecentSearchItemSave {
        do {
            return try await voteRepository.requestRecentSearchItemSave(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteRecentCharacterItemSave(query: RecentCharacterItemSaveQuery) async throws -> RecentCharacterItemSave {
        do {
            return try await voteRepository.requestRecentCharacterItemSave(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteRecentSearchItemDelete(query: RecentSearchItemDeleteQuery) async throws -> RecentSearchItemDelete {
        do {
            return try await voteRepository.deleteRecentSearchItemDelete(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteRecentSearchListDelete(query: RecentSearchItemListDeleteQuery) async throws -> RecentSearchItemListDelete {
        do {
            return try await voteRepository.deleteRecentSearchListDelete(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteRecentCharacterItemDelete(query: RecentCharacterItemDeleteQuery) async throws -> RecentCharacterItemDelete {
        do {
            return try await voteRepository.deleteRecentCharacterItemDelete(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension VoteUseCaseImpl {
    func excuteRecentCharacterListDelete(query: RecentCharacterItemListDeleteQuery) async throws -> RecentCharacterItemListDelete {
        do {
            return try await voteRepository.deleteRecentCharacterListDelete(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}
