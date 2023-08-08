//
//  MyMomentumRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/22.
//

import Foundation

enum MyMomentumRepositoryError: Error {
    case request
}

final class MyMomentumRepositoryImpl: MyMomentumRepository {

    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension MyMomentumRepositoryImpl {
    func fetchMyProfile(query: MyProfileQuery) async throws -> MyProfile {
        let target = MyMomentumAPIEndpoints.getMyProfile(with: query.user_id)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw MyMomentumRepositoryError.request
        }
    }
    
    func requestModifyMyProfile(query: ModifyMyProfileQuery) async throws -> ModifyMyProfile {
        let requestDTO = RequestModifyMyProfileDTO(user_id: query.user_id, profile_img: query.profile_img, intro: query.intro)
       
        let target = MyMomentumAPIEndpoints.postModifyMyProfile(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw MyMomentumRepositoryError.request
        }
    }
    
    func fetchLikeAnimationContent(query: LikeAnimationContentQuery) async throws -> LikeAnimationContent {
        let target = MyMomentumAPIEndpoints.getLikeAnimationContent(with: query.user_id)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw MyMomentumRepositoryError.request
        }
    }
    
    func fetchLikeMovieContent(query: LikeMovieContentQuery) async throws -> LikeMovieContent {
        let target = MyMomentumAPIEndpoints.getLikeMovieContent(with: query.user_id)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw MyMomentumRepositoryError.request
        }
    }
    
    func fetchMyReview(query: GetMyReviewQuery) async throws -> GetMyReview {
        let target = MyMomentumAPIEndpoints.getMyReview(with: query.user_id)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw MyMomentumRepositoryError.request
        }
    }
    
    func fetchMyComment(query: GetMyCommentQuery) async throws -> GetMyComment {
        let target = MyMomentumAPIEndpoints.getMyComment(with: query.user_id)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw MyMomentumRepositoryError.request
        }
    }
    
    func fetchMyVotedCharacter(query: GetMyVotedCharacterQuery) async throws -> GetMyVotedCharacter {
        let target = MyMomentumAPIEndpoints.getMyVotedCharacter(with: query.user_id)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw MyMomentumRepositoryError.request
        }
    }
}
