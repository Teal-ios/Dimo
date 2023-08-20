//
//  ContentAPIEndpoints.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/24.
//

import Foundation

struct ContentAPIEndpoints {
    static func getAnimationData(with query: GetAnimationQuery) -> ContentRouter<ResponseAnimationDataDTO> {
        return ContentRouter<ResponseAnimationDataDTO>.inquireAnimationData(parameters: query)
    }
    
    static func getDetailAnimationData(with content_id: String) -> ContentRouter<ResponseDetailAnimationDataDTO> {
        return ContentRouter<ResponseDetailAnimationDataDTO>.inquireDetailAnimationData(parameters: content_id)
    }
    
    static func postLikeChoice(with requestDTO: RequestLikeChoiceDTO) -> ContentRouter<ResponseLikeChoiceDTO> {
        return ContentRouter<ResponseLikeChoiceDTO>.likeChoice(parameters: LikeChoiceQuery(user_id: requestDTO.user_id, content_type: requestDTO.content_type, contentId: requestDTO.contentId))
    }
    
    static func postLikeCancel(with requestDTO: RequestLikeCancelDTO) -> ContentRouter<ResponseLikeCancelDTO> {
        return ContentRouter<ResponseLikeCancelDTO>.likeCancel(parameters: LikeCancelQuery(user_id: requestDTO.user_id, content_type: requestDTO.content_type, contentId: requestDTO.contentId))
    }
    
    static func postGradeChoiceAndModify(with requestDTO: RequestGradeChoiceAndModifyDTO) -> ContentRouter<ResponseGradeChoiceAndModifyDTO> {
        return ContentRouter<ResponseGradeChoiceAndModifyDTO>.gradeChoiceAndModify(parameters: GradeChoiceAndModifyQuery(user_id: requestDTO.user_id, contentId: requestDTO.contentId, content_type: requestDTO.content_type, grade: requestDTO.grade))
    }
    
    static func getLikeContentCheck(user_id: String, content_type: String, contentId: String) -> ContentRouter<ResponseLikeContentCheckDTO> {
        return ContentRouter<ResponseLikeContentCheckDTO>.likeContentCheck(parameters: LikeContentCheckQuery(user_id: user_id, content_type: content_type, contentId: contentId))
    }
    
    static func getEvaluateMbti(contentId: String, content_type: String) -> ContentRouter<ResponseGetEvaluateMbtiDTO> {
        return ContentRouter<ResponseGetEvaluateMbtiDTO>.getEvalateMbti(parameters: GetEvaluateMbtiQuery(contentId: contentId, content_type: content_type))
    }
    
    static func getGradeEvaluateResult(user_id: String, contentId: String, content_type: String) -> ContentRouter<ResponseGetGradeEvaluateResultDTO> {
        return ContentRouter<ResponseGetGradeEvaluateResultDTO>.getGradeEvaluate(parameters: GetGradeEvaluateResultQuery(user_id: user_id, contentId: contentId, content_type: content_type))
    }
}
