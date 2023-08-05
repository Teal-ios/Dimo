//
//  ResponseGetMyReviewDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/01.
//

import Foundation

struct ResponseGetMyReviewDTO: Decodable {
    let code: Int
    let message: String
    let review: [ResponseMyReviewDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, review
    }
}

extension ResponseGetMyReviewDTO {
    var toDomain: GetMyReview {
        return .init(code: code, message: message, review: review.map { $0?.toDomain })
    }
}
