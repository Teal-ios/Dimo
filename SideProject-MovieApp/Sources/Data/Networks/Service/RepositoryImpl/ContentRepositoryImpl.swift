//
//  ContentRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation
import RxSwift

enum ContentRepositoryError: Error {
    case request
}

final class ContentRepositoryImpl: ContentRepository {

    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension ContentRepositoryImpl {
    func fetchAnimationData(query: GetAnimationQuery) async throws -> AnimationData {
        let target = ContentAPIEndpoints.getAnimationData(with: query)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw ContentRepositoryError.request
        }
    }
}

extension ContentRepositoryImpl {
    func fetchDetailAnimatonData(query: DetailAnimationDataQuery) async throws -> DetailAnimationData {
        let  target = ContentAPIEndpoints.getDetailAnimationData(with: query.content_id)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw ContentRepositoryError.request
        }
    }
}

extension ContentRepositoryImpl {
    func fetchLikeContentCheck(query: LikeContentCheckQuery) async throws -> LikeContentCheck {
        let target = ContentAPIEndpoints.getLikeContentCheck(user_id: query.user_id, content_type: query.content_type, contentId: query.contentId)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw ContentRepositoryError.request
        }
    }
}

extension ContentRepositoryImpl {
    func requestLikeCancel(query: LikeCancelQuery) async throws -> LikeCancel {
        let requestDTO = RequestLikeCancelDTO(user_id: query.user_id, content_type: query.content_type, contentId: query.contentId)
        let target = ContentAPIEndpoints.postLikeCancel(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw ContentRepositoryError.request
        }
    }
}

extension ContentRepositoryImpl {
    func requestLikeChoice(query: LikeChoiceQuery) async throws -> LikeChoice {
        let requestDTO = RequestLikeChoiceDTO(user_id: query.user_id, content_type: query.content_type, contentId: query.contentId)
        let target = ContentAPIEndpoints.postLikeChoice(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw ContentRepositoryError.request
        }
    }
}

extension ContentRepositoryImpl {
    func requestGradeChoiceAndModify(query: GradeChoiceAndModifyQuery) async throws -> GradeChoiceAndModify {
        let requestDTO = RequestGradeChoiceAndModifyDTO(user_id: query.user_id, contentId: query.contentId, content_type: query.content_type, grade: query.grade)
        
        let target = ContentAPIEndpoints.postGradeChoiceAndModify(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw ContentRepositoryError.request
        }
    }
}

extension ContentRepositoryImpl {
    func fetchEvaluateMbti(query: GetEvaluateMbtiQuery) async throws -> GetEvaluateMbti {
        let target = ContentAPIEndpoints.getEvaluateMbti(contentId: query.contentId, content_type: query.content_type)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw ContentRepositoryError.request
        }
    }
}

extension ContentRepositoryImpl {
    func fetchGradeEvaluateResult(query: GetGradeEvaluateResultQuery) async throws -> GetGradeEvaluateResult {
        let target = ContentAPIEndpoints.getGradeEvaluateResult(user_id: query.user_id, contentId: query.contentId, content_type: query.content_type)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw ContentRepositoryError.request
        }
    }
}
