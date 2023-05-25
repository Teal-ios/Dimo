//
//  SettingHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import SnapKit

class SettingHeaderView: UICollectionReusableView {
    static let identifier = "SettingHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black60
       return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        makeConstraints()
    }
    
    convenience init(title: String) {
        self.init()
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let safeArea = self.safeAreaLayoutGuide

        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeArea).inset(8)
            make.centerY.equalTo(safeArea)
            make.height.equalTo(16)
        }
    }
}
