//
//  MyMomentumReusebleHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import SnapKit

class ProfileHeaderView: UICollectionReusableView {
    static let identifier = "ProfileHeaderView"
    
    let profileView: ProfileView = {
        let view = ProfileView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.textAlignment = .left
        label.text = "좋아하는 콘텐츠"
       return label
    }()
    
    let moreButton: WordLabelButton = {
        let button = WordLabelButton(text: "더보기 >")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileView)
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
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(safeArea)
            make.horizontalEdges.equalTo(safeArea)
            make.height.equalTo(320)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(16)
            make.top.equalTo(profileView.snp.bottom).offset(32)
            make.height.equalTo(32)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeArea).offset(-leading)
            make.top.equalTo(profileView.snp.bottom).offset(32)
            make.height.equalTo(32)
        }
    }
}
