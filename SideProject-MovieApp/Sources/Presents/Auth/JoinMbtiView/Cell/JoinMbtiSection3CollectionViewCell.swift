//
//  JoinMbtiSection3CollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/09.
//

import UIKit
import SnapKit

class JoinMbtiSection3CollectionViewCell: BaseCollectionViewCell {
    static let identifier = "JoinMbtiSection3CollectionViewCell"
    var uuid: String?

//    override var isSelected: Bool {
//        didSet {
//            bgView.layer.borderColor = isSelected ? UIColor.purple80.cgColor : UIColor.black80.cgColor
//            mbtiLabel.textColor = isSelected ? .white100 : .black80
//            bgView.backgroundColor = isSelected ? .black90 : .black100
//        }
//    }
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black100
        view.layer.borderColor = UIColor.black80.cgColor
        return view
    }()
    let mbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black80
        label.textAlignment = .center
        return label
    }()

    let imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .black80
        return view
    }()
    
    override func layoutSubviews() {
        bgView.layer.cornerRadius = 8
        bgView.layer.borderWidth = 1
    }
        
    override func configure() {
        [bgView, imgView, mbtiLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.width.equalTo(24)
            make.height.equalTo(28)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(75)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(16)
        }
    }
    
    func configure(with item: JoinMbtiModel) {
        if item.mbti == "내향형" {
            self.bgView.layer.borderColor = UIColor.black80.cgColor
            self.mbtiLabel.textColor = .black80
            self.bgView.backgroundColor = .black100
        }
    }
}
