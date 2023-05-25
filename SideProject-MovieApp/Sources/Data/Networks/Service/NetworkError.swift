//
//  NetworkError.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

enum NetworkError: Error {
    case unexpectedData
    case decodingError
    case clientError
    case serverError
    case internalError
}
