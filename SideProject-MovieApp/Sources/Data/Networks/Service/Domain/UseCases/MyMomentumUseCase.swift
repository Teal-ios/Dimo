//
//  MyMomentumUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/22.
//

import Foundation

protocol MyMomentumUseCase {
    func excuteMyProfile(query: MyProfileQuery) async throws -> MyProfile
    
    func excuteModifyMyProfile(query: ModifyMyProfileQuery) async throws -> ModifyMyProfile

    func excuteLikeAnimationContent(query: LikeAnimationContentQuery) async throws -> LikeAnimationContent

    func excuteLikeMovieContent(query: LikeMovieContentQuery) async throws -> LikeMovieContent

}

enum MyMomentumUseCaseError: String, Error {
    case excute
}

final class MyMomentumUseCaseImpl: MyMomentumUseCase {
    
    private let myMomentumRepository: MyMomentumRepository

    init(myMomentumRepository: MyMomentumRepository) {
        self.myMomentumRepository = myMomentumRepository
    }
}

extension MyMomentumUseCaseImpl {
    
    func excuteMyProfile(query: MyProfileQuery) async throws -> MyProfile {
        do {
            return try await myMomentumRepository.fetchMyProfile(query: query)
        } catch {
            throw MyMomentumUseCaseError.excute
        }
    }
}

extension MyMomentumUseCaseImpl {
    
    func excuteModifyMyProfile(query: ModifyMyProfileQuery) async throws -> ModifyMyProfile {
        do {
            return try await myMomentumRepository.requestModifyMyProfile(query: query)
        } catch {
            throw MyMomentumUseCaseError.excute
        }
    }
}

extension MyMomentumUseCaseImpl {
    
    func excuteLikeAnimationContent(query: LikeAnimationContentQuery) async throws -> LikeAnimationContent {
        do {
            return try await myMomentumRepository.fetchLikeAnimationContent(query: query)
        } catch {
            throw MyMomentumUseCaseError.excute
        }
    }
}

extension MyMomentumUseCaseImpl {
    
    func excuteLikeMovieContent(query: LikeMovieContentQuery) async throws -> LikeMovieContent {
        do {
            return try await myMomentumRepository.fetchLikeMovieContent(query: query)
        } catch {
            throw MyMomentumUseCaseError.excute
        }
    }
}
