//
//  VoteCollectionHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import UIKit
import SnapKit

class VoteHeaderView: UICollectionReusableView {
    static let identifier = "VoteHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        label.text = "지금 핫한 캐릭터"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
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
    }
}
