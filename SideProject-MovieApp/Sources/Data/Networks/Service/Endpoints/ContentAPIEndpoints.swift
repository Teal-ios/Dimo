//
//  ContentAPIEndpoints.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/24.
//

import Foundation

struct ContentAPIEndpoints {
    static func getAnimationData() -> ContentRouter<[ResponseAnimationDataDTO]> {
        return ContentRouter<[ResponseAnimationDataDTO]>.inquireAnimationData
    }
    
    static func getDetailAnimationData(with content_id: String) -> ContentRouter<ResponseDetailAnimationDataDTO> {
        return ContentRouter<ResponseDetailAnimationDataDTO>.inquireDetailAnimationData(parameters: content_id)
    }
}
