//
//  FeedDetailHideReviewAlertView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import UIKit
import SnapKit

final class FeedDetailHideReviewAlertView: BaseView {
    let alertView: AlertButtonSecondView = {
        let view = AlertButtonSecondView(title: "리뷰 가리기", subtitle: "리뷰를 가릴까요?\n가린 글은 다시 볼 수 없습니다.", okButtonTitle: "아니요", cancelButtonTitle: "가리기")
        return view
    }()
    
    override func setHierarchy() {
        self.addSubview(alertView)
    }
    
    override func setupLayout() {
        
        alertView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        alertView.backgroundColor = .clear
    }
}
