//
//  CharacterDetailRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

enum CharacterDetailRepositoryError: Error {
    case request
}

final class CharacterDetailRepositoryImpl: CharacterDetailRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension CharacterDetailRepositoryImpl {
    func requestPostReview(query: PostReviewQuery) async throws -> PostReview {
        let requestDTO = RequestPostReviewDTO(user_id: query.user_id, character_id: query.character_id, review_content: query.review_content, review_spoiler: query.review_spoiler)
        let target = CharacterDetailAPIEndpoints.postReview(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw CharacterDetailRepositoryError.request
        }
    }
}

extension CharacterDetailRepositoryImpl {
    func fetchGetReview(query: GetReviewQuery) async throws -> GetReview {
        let target = CharacterDetailAPIEndpoints.getReview(with: query)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw CharacterDetailRepositoryError.request
        }
    }
}

extension CharacterDetailRepositoryImpl {
    func requestLikeReviewChoice(query: LikeReviewChoiceQuery) async throws -> LikeReviewChoice {
        let requestDTO = RequestLikeReviewChoiceDTO(user_id: query.user_id, character_id: query.character_id, review_id: query.review_id)
        let target = CharacterDetailAPIEndpoints.postLikeReviewChoice(with: requestDTO)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw CharacterDetailRepositoryError.request
        }
    }
}

extension CharacterDetailRepositoryImpl {
    func requestLikeReviewCancel(query: LikeReviewCancelQuery) async throws -> LikeReviewCancel {
        let requestDTO = RequestLikeReviewCancelDTO(user_id: query.user_id, character_id: query.character_id, review_id: query.review_id)
        let target = CharacterDetailAPIEndpoints.postLikeReviewCancel(wtih: requestDTO)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw CharacterDetailRepositoryError.request
        }
    }
}

extension CharacterDetailRepositoryImpl {
    func requestModifyReview(query: ModifyReviewQuery) async throws -> ModifyReview {
        let requestDTO = RequestModifyReviewDTO(user_id: query.user_id, character_id: query.character_id, review_content: query.review_content, review_spoiler: query.review_spoiler, review_id: query.review_id)
        let target = CharacterDetailAPIEndpoints.postModifyReview(with: requestDTO)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw CharacterDetailRepositoryError.request
        }
    }
}

extension CharacterDetailRepositoryImpl {
    func deleteReview(query: DeleteReviewQuery) async throws -> DeleteReview {
        let requestDTO = RequestDeleteReviewDTO(user_id: query.user_id, character_id: query.character_id, review_id: query.review_id)
        let target = CharacterDetailAPIEndpoints.deleteReview(with: requestDTO)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw CharacterDetailRepositoryError.request
        }
    }
}

extension CharacterDetailRepositoryImpl {
    func requestPostComment(query: PostCommentQuery) async throws -> PostComment {
        let requestDTO = RequestPostCommentDTO(user_id: query.user_id, character_id: query.character_id, review_id: query.review_id, comment_content: query.comment_content, comment_spoiler: query.comment_spoiler)
        let target = CharacterDetailAPIEndpoints.postComment(with: requestDTO)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw CharacterDetailRepositoryError.request
        }
    }
}

extension CharacterDetailRepositoryImpl {
    func fetchGetComment(query: GetCommentQuery) async throws -> GetComment {
        let target = CharacterDetailAPIEndpoints.getComment(with: query)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw CharacterDetailRepositoryError.request
        }
    }
}

extension CharacterDetailRepositoryImpl {
    func fetchGetReviewDetail(query: GetReviewDetailQuery) async throws -> GetReviewDetail {
        let target = CharacterDetailAPIEndpoints.getReviewDetail(with: query)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw CharacterDetailRepositoryError.request
        }
    }
}
