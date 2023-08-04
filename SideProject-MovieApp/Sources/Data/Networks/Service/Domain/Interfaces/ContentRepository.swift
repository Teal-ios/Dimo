//
//  ContentRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation

protocol ContentRepository: AnyObject {
    
    func fetchAnimationData(query: GetAnimationQuery) async throws -> AnimationData
    
    func fetchDetailAnimatonData(query: DetailAnimationDataQuery) async throws -> DetailAnimationData
    
    func requestLikeChoice(query: LikeChoiceQuery) async throws -> LikeChoice
    
    func requestLikeCancel(query: LikeCancelQuery) async throws -> LikeCancel
    
    func requestGradeChoiceAndModify(query: GradeChoiceAndModifyQuery) async throws -> GradeChoiceAndModify
    
    func fetchLikeContentCheck(query: LikeContentCheckQuery) async throws -> LikeContentCheck
}
