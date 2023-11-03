//
//  VoteRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/30.
//

import Foundation

protocol VoteRepository {
    
    func fetchRandomCharacterRecommend(query: RandomCharacterRecommendQuery) async throws -> RandomCharacterRecommendList
    
    func fetchPopularCharacterRecommendList(query: PopularCharacterRecommendListQuery) async throws -> PopularCharacterRecommendList
    
    func fetchSearchCharacterList(query: SearchCharacterListQuery) async throws -> SearchCharacterList
    
    func fetchSearchWorkList(query: SearchWorkListQuery) async throws -> SearchWorkList
    
    func requestVoteCharacter(query: VoteCharacterQuery) async throws -> VoteCharacter
    
    func fetchSameWorkCharacterList(query: SameWorkCharacterListQuery) async throws -> SameWorkCharacterList
    
    func fetchInquireVoteResult(query: InquireVoteResultQuery) async throws -> InquireVoteResult
    
    func fetchInquireCharacterAnalyze(query: InquireCharacterAnalyzeQuery) async throws -> InquireCharacterAnalyze
    
    func fetchRecentSearchList(query: RecentSearchListQuery) async throws -> RecentSearchList
    
    func fetchRecentCharacterList(query: RecentCharacterListQuery) async throws -> RecentCharacterList
    
    func requestRecentSearchItemSave(query: RecentSearchItemSaveQuery) async throws -> RecentSearchItemSave
    
    func requestRecentCharacterItemSave(query: RecentCharacterItemSaveQuery) async throws -> RecentCharacterItemSave
    
    func deleteRecentSearchItemDelete(query: RecentSearchItemDeleteQuery) async throws -> RecentSearchItemDelete
    
    func deleteRecentSearchListDelete(query: RecentSearchItemListDeleteQuery) async throws -> RecentSearchItemListDelete
    
    func deleteRecentCharacterItemDelete(query: RecentCharacterItemDeleteQuery) async throws -> RecentCharacterItemDelete
    
    func deleteRecentCharacterListDelete(query: RecentCharacterItemListDeleteQuery) async throws -> RecentCharacterItemListDelete
}
