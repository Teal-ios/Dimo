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
    
    func requestVoteCharacter(query: VoteCharacterQuery) async throws -> VoteCharacter
    
    func fetchSameWorkCharacterList(query: SameWorkCharacterListQuery) async throws -> SameWorkCharacterList
}
