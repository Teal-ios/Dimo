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
