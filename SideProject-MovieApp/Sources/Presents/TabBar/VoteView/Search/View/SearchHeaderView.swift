//
//  SearchHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/04.
//

import UIKit
import SnapKit

final class SearchHeaderView: UICollectionReusableView {
    static let identifier = "SearchHeaderView"
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black60
       return label
    }()
    
    let moreButton: WordLabelButton = {
        let button = WordLabelButton(text: "전체삭제")
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
    
    convenience init(title: String) {
        self.init()
        titleLabel.text = title
    }
    func makeConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeArea)
            make.top.equalTo(safeArea)
            make.height.equalTo(18)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeArea)
            make.top.equalTo(safeArea)
            make.height.equalTo(18)
        }
    }
}
