//
//  FeedDetailMoreMyView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import UIKit
import SnapKit

final class FeedDetailMoreMyView: BaseView {
        
    let selfView: CategoryView = {
        let view = CategoryView()
        view.backgroundColor = .clear
        view.titleLabel.text = "더보기"
        view.movieLabel.text = "수정하기"
        view.animationLabel.text = "삭제하기"
        view.animationLabel.textColor = .black5
        return view
    }()
    
    override func setHierarchy() {
        self.addSubview(selfView)
    }
    
    override func setupLayout() {
        selfView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}
