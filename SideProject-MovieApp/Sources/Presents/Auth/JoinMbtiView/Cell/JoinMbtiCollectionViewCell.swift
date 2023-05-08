//
//  JoinMbtiCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/08.
//

import UIKit
import SnapKit

class JoinMbtiCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "JoinMbtiCollectionViewCell"
    
    var sectionSelected: [Int] = [0, 0, 0, 0]

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

//bgView.layer.borderColor = isSelected ? UIColor.purple80.cgColor : UIColor.black80.cgColor
//mbtiLabel.textColor = isSelected ? .white100 : .black80
//bgView.backgroundColor = isSelected ? .black90 : .black100


//[JoinMbtiModel(image: UIImage(named: "E"), mbti: "외향형"),
// JoinMbtiModel(image: UIImage(named: "I"), mbti: "내향형")]
//    .forEach { section1Arr.append($0) }
//[JoinMbtiModel(image: UIImage(named: "N"), mbti: "직관형"),
// JoinMbtiModel(image: UIImage(named: "S"), mbti: "감각형")]
//    .forEach { section2Arr.append($0) }
//[JoinMbtiModel(image: UIImage(named: "T"), mbti: "사고형"),
// JoinMbtiModel(image: UIImage(named: "F"), mbti: "감정형")]
//    .forEach { section3Arr.append($0) }
//[JoinMbtiModel(image: UIImage(named: "J"), mbti: "판단형"),
// JoinMbtiModel(image: UIImage(named: "P"), mbti: "인식형")]
