//
//  CharacterDetailAPIEndpoints.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct CharacterDetailAPIEndpoints {
    static func postReview(with requestDTO: RequestPostReviewDTO) -> CharacterDetailRouter<ResponsePostReviewDTO> {
        return CharacterDetailRouter<ResponsePostReviewDTO>.postReview(parameters: PostReviewQuery(user_id: requestDTO.user_id, character_id: requestDTO.character_id, review_content: requestDTO.review_content, review_spoiler: requestDTO.review_spoiler))
    }
    
    static func getReview(with query: GetReviewQuery) -> CharacterDetailRouter<ResponseGetReviewDTO> {
        return CharacterDetailRouter<ResponseGetReviewDTO>.getReview(parameters: query)
    }
    
    static func postLikeReviewChoice(with requestDTO: RequestLikeReviewChoiceDTO) -> CharacterDetailRouter<ResponseLikeReviewChoiceDTO> {
        return CharacterDetailRouter<ResponseLikeReviewChoiceDTO>.likeReviewChoice(parameters: LikeReviewChoiceQuery(user_id: requestDTO.user_id, character_id: requestDTO.character_id, review_id: requestDTO.review_id))
    }
    
    static func postLikeReviewCancel(wtih requestDTO: RequestLikeReviewCancelDTO) -> CharacterDetailRouter<ResponseLikeReviewCancelDTO> {
        return CharacterDetailRouter<ResponseLikeReviewCancelDTO>.likeReviewCancel(parameters: LikeReviewCancelQuery(user_id: requestDTO.user_id, character_id: requestDTO.character_id, review_id: requestDTO.review_id))
    }
    
    static func postModifyReview(with requestDTO: RequestModifyReviewDTO) -> CharacterDetailRouter<ResponseModifyReviewDTO> {
        return CharacterDetailRouter<ResponseModifyReviewDTO>.modifyReview(parameters: ModifyReviewQuery(user_id: requestDTO.user_id, character_id: requestDTO.character_id, review_content: requestDTO.review_content, review_spoiler: requestDTO.review_spoiler, review_id: requestDTO.review_id))
    }
    
    static func deleteReview(with requestDTO: RequestDeleteReviewDTO) -> CharacterDetailRouter<ResponseDeleteReviewDTO> {
        return CharacterDetailRouter<ResponseDeleteReviewDTO>.deleteReview(parameters: DeleteReviewQuery(user_id: requestDTO.user_id, character_id: requestDTO.character_id, review_id: requestDTO.review_id))
    }
    
    static func postComment(with requestDTO: RequestPostCommentDTO) -> CharacterDetailRouter<ResponsePostCommentDTO> {
        return CharacterDetailRouter<ResponsePostCommentDTO>.postComment(parameters: PostCommentQuery(user_id: requestDTO.user_id, character_id: requestDTO.character_id, review_id: requestDTO.review_id, comment_content: requestDTO.comment_content, comment_spoiler: requestDTO.comment_spoiler))
    }
    
    static func getComment(with query: GetCommentQuery) -> CharacterDetailRouter<ResponseGetCommentDTO> {
        return CharacterDetailRouter<ResponseGetCommentDTO>.getComment(parameters: query)
    }
    
    static func getReviewDetail(with query: GetReviewDetailQuery) -> CharacterDetailRouter<ResponseGetReviewDetailDTO> {
        return CharacterDetailRouter<ResponseGetReviewDetailDTO>.getReviewDetail(parameters: query)
    }
}
