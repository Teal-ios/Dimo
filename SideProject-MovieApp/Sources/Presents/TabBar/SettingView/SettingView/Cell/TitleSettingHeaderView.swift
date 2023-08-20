//
//  TitleSettingHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import SnapKit

class TitleSettingHeaderView: UICollectionReusableView {
    static let identifier = "TitleSettingHeaderView"
    
    let mainTitleLable: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.text = "설정"
        label.font = Font.title1
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black60
       return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mainTitleLable)
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

        mainTitleLable.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeArea).inset(8)
            make.top.equalTo(safeArea).offset(36)
            make.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeArea).inset(8)
            make.top.equalTo(mainTitleLable.snp.bottom).offset(36)
            make.height.equalTo(16)
        }
    }
}
