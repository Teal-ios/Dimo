//
//  MyMomentumExceptionHandlingCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/24.
//

import UIKit
import SnapKit

final class MyMomentumExceptionHandlingCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "MyMomentumExceptionHandlingCollectionViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textAlignment = .left
        return label
    }()
    
    let introduceView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black90
        return view
    }()
    
    let introduceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        introduceView.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(introduceView)
        self.addSubview(introduceLabel)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.height.equalTo(24)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(32)
            make.height.greaterThanOrEqualTo(20)
        }
        
        introduceView.snp.makeConstraints { make in
            make.edges.equalTo(introduceLabel).inset(-16)
        }
    }
}
