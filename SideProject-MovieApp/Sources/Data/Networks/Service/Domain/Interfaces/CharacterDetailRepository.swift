//
//  CharacterDetailRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/30.
//

import Foundation

protocol CharacterDetailRepository {
 
    func requestPostReview(query: PostReviewQuery) async throws -> PostReview
    
    func fetchGetReview(query: GetReviewQuery) async throws -> GetReview
    
    func requestLikeReviewChoice(query: LikeReviewChoiceQuery) async throws -> LikeReviewChoice
    
    func requestLikeReviewCancel(query: LikeReviewCancelQuery) async throws -> LikeReviewCancel
    
    func requestLikeCommentChoice(query: LikeCommentChoiceQuery) async throws -> LikeCommentChoice
    
    func requestLikeCommentCancel(query: LikeCommentCancelQuery) async throws -> LikeCommentCancel
    
    func requestModifyReview(query: ModifyReviewQuery) async throws -> ModifyReview
    
    func deleteReview(query: DeleteReviewQuery) async throws -> DeleteReview
    
    func requestPostComment(query: PostCommentQuery) async throws -> PostComment
    
    func fetchGetComment(query: GetCommentQuery) async throws -> GetComment
    
    func fetchGetReviewDetail(query: GetReviewDetailQuery) async throws -> GetReviewDetail
}
