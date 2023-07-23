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
        label.textColor = .black5
        label.text = "Today's DIMO"
       return label
    }()
    
    let categoryInsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "영화"
        return label
    }()
    
    let arrowBottomLabel: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow_bottom")
        return view
    }()
    
    let categoryButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryButton.layer.cornerRadius = 8
        categoryButton.layer.borderWidth = 1
        categoryButton.backgroundColor = .black90
        categoryButton.tintColor = Color.caption
        categoryButton.layer.borderColor = UIColor.black80.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(categoryButton)
        self.addSubview(categoryInsetLabel)
        self.addSubview(arrowBottomLabel)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(8)
            make.horizontalEdges.equalTo(safeArea).inset(16)
            make.height.equalTo(32)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.height.equalTo(32)
            make.width.equalTo(69)
            make.leading.equalTo(safeArea).inset(16)
        }
        
        categoryInsetLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryButton.snp.leading).offset(12)
            make.width.equalTo(25)
            make.height.equalTo(21)
            make.centerY.equalTo(categoryButton)
        }
        
        arrowBottomLabel.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.centerY.equalTo(categoryButton)
            make.leading.equalTo(categoryInsetLabel.snp.trailing).offset(4)
        }
    }
}
