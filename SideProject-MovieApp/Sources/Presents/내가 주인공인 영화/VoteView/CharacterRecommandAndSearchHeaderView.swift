//
//  CharacterRecommandAndSearchHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import UIKit
import SnapKit

class CharacterRecommandAndSearchHeaderView: UICollectionReusableView {
    static let identifier = "CharacterRecommandAndSearchHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        label.text = "Dig me!"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .suitFont(ofSize: 16, weight: .Medium)
        label.text = "MBTI를 투표해 주세요"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
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
            make.top.equalTo(safeArea).offset(72)
            make.height.equalTo(32)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(18)
        }
    }
}
