//
//  ScopeView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import SnapKit

class testView: BaseView {
    let scopeStackView: ScopeStackView = {
        let view = ScopeStackView()
        view.setRatingImageView()
        return view
    }()
    
    override func setupLayout() {
        self.addSubview(scopeStackView)
        scopeStackView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
