//
//  ContentUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation
import RxSwift

protocol ContentUseCase {
    func excuteFetchAnimationData() -> Observable<[AnimationData]>
    
    func excuteFetchDetailAnimationData(query: DetailAnimationDataQuery) async throws -> DetailAnimationData
    
    func excuteGradeChoiceAndModify(query: GradeChoiceAndModifyQuery) async throws -> GradeChoiceAndModify
    
    func excuteLikeChoice(query: LikeChoiceQuery) async throws -> LikeChoice
    
    func excuteLikeCancel(query: LikeCancelQuery) async throws -> LikeCancel
    
    func excuteLikeContentCheck(query: LikeContentCheckQuery) async throws -> LikeContentCheck
}

enum ContentUseCaseError: String, Error {
    case excute
}

final class ContentUseCaseImpl: ContentUseCase {
    private let contentRepository: ContentRepository

    init(contentRepository: ContentRepository) {
        self.contentRepository = contentRepository
    }
}

extension ContentUseCaseImpl {
    func excuteFetchAnimationData() -> Observable<[AnimationData]> {
        let animationDataObservable: Observable<[AnimationData]> = Observable.create { observer in
            let task = Task {
                let animationData = try await self.contentRepository.fetchAnimationData()
                observer.on(.next(animationData))
                observer.on(.completed)
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
        
        return animationDataObservable
    }
}

extension ContentUseCaseImpl {
    func excuteFetchDetailAnimationData(query: DetailAnimationDataQuery) async throws -> DetailAnimationData {
        do {
            return try await contentRepository.fetchDetailAnimatonData(query: query)
        } catch {
            throw ContentUseCaseError.excute
        }
    }
}

extension ContentUseCaseImpl {
    func excuteLikeContentCheck(query: LikeContentCheckQuery) async throws -> LikeContentCheck {
        do {
            return try await contentRepository.fetchLikeContentCheck(query: query)
        } catch {
            throw ContentUseCaseError.excute
        }
    }
}

extension ContentUseCaseImpl {
    func excuteGradeChoiceAndModify(query: GradeChoiceAndModifyQuery) async throws -> GradeChoiceAndModify {
        do {
            return try await contentRepository.requestGradeChoiceAndModify(query: query)
        } catch {
            throw ContentUseCaseError.excute
        }
    }
}

extension ContentUseCaseImpl {
    func excuteLikeChoice(query: LikeChoiceQuery) async throws -> LikeChoice {
        do {
            return try await contentRepository.requestLikeChoice(query: query)
        } catch {
            throw ContentUseCaseError.excute
        }
    }
}

extension ContentUseCaseImpl {
    func excuteLikeCancel(query: LikeCancelQuery) async throws -> LikeCancel {
        do {
            return try await contentRepository.requestLikeCancel(query: query)
        } catch {
            throw ContentUseCaseError.excute
        }
    }
}
