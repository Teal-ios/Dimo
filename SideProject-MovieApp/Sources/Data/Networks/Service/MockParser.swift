//
//  MockParser.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation

final class MockParser {
    static func load() -> [AnimationData]? {
        guard let path = Bundle.main.path(forResource: "Mock", ofType: "json") else {
            return nil
        }
        
        guard let jsonString = try? String(contentsOfFile: path) else {
            return nil
        }
        let cleanedJsonString = jsonString.replacingOccurrences(of: "\\n<br>", with: "")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print(cleanedJsonString, "jsonData to String")
        
        do {
            guard let data = cleanedJsonString.data(using: .utf8) else {
                return nil
            }
            let responseDTO = try decoder.decode([ResponseAnimationDataDTO].self, from: data)
            print(responseDTO,"이건찍히나")
            let animationData = responseDTO.map { $0.toDomain }
            print(animationData,"이거는?")
            return animationData
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

