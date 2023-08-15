//
//  GetMyVotedCharacter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import Foundation

struct GetMyVotedCharacter: Hashable {
    let code: Int
    let message: String
    let voted_character: [MyVotedCharacter?]
}
