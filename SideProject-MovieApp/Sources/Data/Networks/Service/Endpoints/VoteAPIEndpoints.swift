//
//  VoteAPIEndpoints.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct VoteAPIEndpoints {
    static func getRandomCharacterRecommend(with query: RandomCharacterRecommendQuery) -> VoteRouter<ResponseRandomCharacterRecommendListDTO> {
        return VoteRouter<ResponseRandomCharacterRecommendListDTO>.randomCharacterRecommend(parameters: query)
    }
    
    static func getPopularCharacterRecommend(with query: PopularCharacterRecommendListQuery) -> VoteRouter<ResponsePopularCharacterRecommendListDTO> {
        return VoteRouter<ResponsePopularCharacterRecommendListDTO>.popularCharacterRecommendList(parameters: query)
    }
    
    static func getSearchCharacterList(with query: SearchCharacterListQuery) -> VoteRouter<ResponseSearchCharacterListDTO> {
        return VoteRouter<ResponseSearchCharacterListDTO>.searchCharacterList(parameters: query)
    }
    
    static func getSearchWorkList(with query: SearchWorkListQuery) -> VoteRouter<ResponseSearchWorkListDTO> {
        return VoteRouter<ResponseSearchWorkListDTO>.searchWorkList(parameters: query)
    }
    
    static func postVoteCharacter(with requestDTO: RequestVoteCharacterDTO) -> VoteRouter<ResponseVoteCharacterDTO> {
        return VoteRouter<ResponseVoteCharacterDTO>.voteCharacter(parameters: VoteCharacterQuery(user_id: requestDTO.user_id, content_id: requestDTO.contentId, character_id: requestDTO.character_id, ei: requestDTO.ei, sn: requestDTO.sn, tf: requestDTO.tf, jp: requestDTO.jp))
    }
    
    static func getSameCharacterList(with query: SameWorkCharacterListQuery) -> VoteRouter<ResponseSameWorkCharacterListDTO> {
        return VoteRouter<ResponseSameWorkCharacterListDTO>.sameWorkCharacterList(parameters: query)
    }
    
    static func getInquireVoteResult(with query: InquireVoteResultQuery) -> VoteRouter<ResponseInquireVoteResultDTO> {
        return VoteRouter<ResponseInquireVoteResultDTO>.inquireVoteResult(parameters: query)
    }
    
    static func getInquireCharacterAnalyze(with query: InquireCharacterAnalyzeQuery) -> VoteRouter<ResponseInquireCharacterAnalyzeDTO> {
        return VoteRouter<ResponseInquireCharacterAnalyzeDTO>.inquireCharacterAnalyze(parameters: query)
    }
}
