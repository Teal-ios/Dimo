//
//  CategoryModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/16.
//

import UIKit

struct CategoryModel: Hashable {
    let id = UUID()
    let category: String?
    let spoil: Bool?
}

