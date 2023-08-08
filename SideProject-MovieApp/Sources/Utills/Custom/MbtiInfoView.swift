//
//  MbtiInfoView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import UIKit
import SnapKit

final class MbtiInfoView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black90
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(mbti: String, explainText: String, image: UIImage?) {
        self.init()
        self.imageView.image = image
        let attributeText = NSMutableAttributedString(string: mbti + explainText)
        let mbtiFont = Font.subtitle3
        let attributes: [NSAttributedString.Key: Any] = [
            .font: mbtiFont,
            .foregroundColor: UIColor.black5,
        ]
        attributeText.addAttributes(attributes, range: (mbti as NSString).range(of: mbti))
        self.explainLabel.attributedText = attributeText
    }
    
    override func layoutSubviews() {
        bgView.layer.cornerRadius = 8
    }
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(imageView)
        self.addSubview(explainLabel)
    }
    
    override func setupLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.top).offset(16)
            make.bottom.equalTo(bgView.snp.bottom).offset(-16)
            make.leading.equalTo(bgView.snp.leading).offset(16)
            make.width.equalTo(24)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.top.equalTo(imageView.snp.top)
            make.bottom.equalTo(imageView.snp.bottom)
            make.trailing.equalTo(bgView.snp.trailing)
        }
    }
}
