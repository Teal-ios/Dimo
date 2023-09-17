//
//  CharacterDetailUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

protocol CharacterDetailUseCase {
    func excutePostReview(query: PostReviewQuery) async throws -> PostReview
    
    func excuteGetReview(query: GetReviewQuery) async throws -> GetReview
    
    func excuteLikeReviewChoice(query: LikeReviewChoiceQuery) async throws -> LikeReviewChoice
    
    func excuteLikeReviewCancel(query: LikeReviewCancelQuery) async throws -> LikeReviewCancel
    
    func excuteLikeCommentChoice(query: LikeCommentChoiceQuery) async throws -> LikeCommentChoice
    
    func excuteLikeCommentCancel(query: LikeCommentCancelQuery) async throws -> LikeCommentCancel
    
    func excuteModifyReview(query: ModifyReviewQuery) async throws -> ModifyReview
    
    func excuteDeleteReview(query: DeleteReviewQuery) async throws -> DeleteReview
    
    func excutePostComment(query: PostCommentQuery) async throws -> PostComment
    
    func excuteGetComment(query: GetCommentQuery) async throws -> GetComment
    
    func excuteGetReviewDetail(query: GetReviewDetailQuery) async throws -> GetReviewDetail
    
    func excuteBlindReview(query: PostBlindReviewQuery) async throws -> BlindReview
    
    func excuteReportUser(query: PostReportUserQuery) async throws -> ReportUser
}

enum CharacterDetailUseCaseError: String, Error {
    case excute
}

final class CharacterDetailUseCaseImpl: CharacterDetailUseCase {
    
    private let characterDetailRepository: CharacterDetailRepository

    init(characterDetailRepository: CharacterDetailRepository) {
        self.characterDetailRepository = characterDetailRepository
    }
}

extension CharacterDetailUseCaseImpl {
    func excutePostReview(query: PostReviewQuery) async throws -> PostReview {
        do {
            return try await characterDetailRepository.requestPostReview(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteGetReview(query: GetReviewQuery) async throws -> GetReview {
        do {
            return try await characterDetailRepository.fetchGetReview(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}


extension CharacterDetailUseCaseImpl {
    func excuteLikeReviewChoice(query: LikeReviewChoiceQuery) async throws -> LikeReviewChoice {
        do {
            return try await characterDetailRepository.requestLikeReviewChoice(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteLikeReviewCancel(query: LikeReviewCancelQuery) async throws -> LikeReviewCancel {
        do {
            return try await characterDetailRepository.requestLikeReviewCancel(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteLikeCommentChoice(query: LikeCommentChoiceQuery) async throws -> LikeCommentChoice {
        do {
            return try await characterDetailRepository.requestLikeCommentChoice(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteLikeCommentCancel(query: LikeCommentCancelQuery) async throws -> LikeCommentCancel {
        do {
            return try await characterDetailRepository.requestLikeCommentCancel(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteModifyReview(query: ModifyReviewQuery) async throws -> ModifyReview {
        do {
            return try await characterDetailRepository.requestModifyReview(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteDeleteReview(query: DeleteReviewQuery) async throws -> DeleteReview {
        do {
            return try await characterDetailRepository.deleteReview(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}
extension CharacterDetailUseCaseImpl {
    func excutePostComment(query: PostCommentQuery) async throws -> PostComment {
        do {
            return try await characterDetailRepository.requestPostComment(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteGetComment(query: GetCommentQuery) async throws -> GetComment {
        do {
            return try await characterDetailRepository.fetchGetComment(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteGetReviewDetail(query: GetReviewDetailQuery) async throws -> GetReviewDetail {
        do {
            return try await characterDetailRepository.fetchGetReviewDetail(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteBlindReview(query: PostBlindReviewQuery) async throws -> BlindReview {
        do {
            return try await characterDetailRepository.reqeustBlindReview(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}

extension CharacterDetailUseCaseImpl {
    func excuteReportUser(query: PostReportUserQuery) async throws -> ReportUser {
        do {
            return try await characterDetailRepository.reqeustReportUser(query: query)
        } catch {
            throw VoteUseCaseError.excute
        }
    }
}
