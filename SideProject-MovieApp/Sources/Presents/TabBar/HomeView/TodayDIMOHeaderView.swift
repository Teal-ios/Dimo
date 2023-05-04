//
//  TodayDIMOHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import SnapKit

class TodayDIMOHeaderView: UICollectionReusableView {
    static let identifier = "TodayDIMOHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.textColor = .white100
        label.text = "Today's DIMO"
       return label
    }()
    
    let categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("영화 >", for: .normal)
        button.titleLabel?.font = Font.body3
        button.titleLabel?.textColor = Color.caption
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryButton.layer.cornerRadius = 8
        categoryButton.layer.borderWidth = 1
        categoryButton.backgroundColor = .black100
        categoryButton.tintColor = Color.caption
        categoryButton.layer.borderColor = Color.caption.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(categoryButton)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let leading = 16.0
        let safeArea = self.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(8)
            make.horizontalEdges.equalTo(safeArea).inset(16)
            make.height.equalTo(32)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.height.equalTo(32)
            make.width.equalTo(68)
            make.leading.equalTo(safeArea).inset(16)
        }
    }
}
