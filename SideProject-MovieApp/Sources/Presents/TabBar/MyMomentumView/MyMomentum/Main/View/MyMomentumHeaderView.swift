//
//  MyMomentumHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import SnapKit

class MyMomentumHeaderView: UICollectionReusableView {
    static let identifier = "MyMomentumHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.textAlignment = .left
        label.text = "내가 찜한 콘텐츠"
       return label
    }()
    
    let moreButton: WordLabelButton = {
        let button = WordLabelButton(text: "더보기 >")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(moreButton)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let leading = 16.0
        let safeArea = self.safeAreaLayoutGuide
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leading)
            make.top.equalTo(safeArea)
            make.height.equalTo(32)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeArea).offset(-leading)
            make.top.equalTo(safeArea)
            make.height.equalTo(32)
        }
    }
}
