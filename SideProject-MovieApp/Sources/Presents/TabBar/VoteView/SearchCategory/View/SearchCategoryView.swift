//
//  SearchCategoryView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/23.
//

import UIKit
import SnapKit

import UIKit
import SnapKit

final class SearchCategoryView: BaseView {
        
    let selfView: CategoryView = {
        let view = CategoryView()
        view.backgroundColor = .clear
        view.titleLabel.text = "더보기"
        view.movieLabel.text = "작품명"
        view.animationLabel.text = "캐릭터명"
        view.animationLabel.textColor = .black5
        view.movieLabel.textColor = .black60
        return view
    }()
    
    override func setHierarchy() {
        self.addSubview(selfView)
    }
    
    override func setupLayout() {
        selfView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension SearchCategoryView {
    func configureCategoryCase(category: SearchCategoryCase) {
        switch category {
            
        case .character:
            selfView.animationLabel.textColor = .black5
            selfView.movieLabel.textColor = .black60
        case .work:
            selfView.movieLabel.textColor = .black5
            selfView.animationLabel.textColor = .black60
        }
    }
}
