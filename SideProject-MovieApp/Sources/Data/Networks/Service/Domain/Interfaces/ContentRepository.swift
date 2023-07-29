//
//  ContentRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation

protocol ContentRepository: AnyObject {
    
    func fetchAnimationData() async throws -> [AnimationData]
    
    func fetchDetailAnimatonData(query: DetailAnimationDataQuery) async throws -> DetailAnimationData
}
