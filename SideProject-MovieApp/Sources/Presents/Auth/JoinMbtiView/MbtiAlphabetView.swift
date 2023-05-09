//
//  mbtiAlphabetView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/09.
//

import UIKit
import SnapKit

class MbtiAlphabetView: BaseView {
    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .black80
        return view
    }()
    
    let mbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black80
        label.textAlignment = .center
        return label
    }()
    
    lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imgView, mbtiLabel
        ])
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(image: UIImage?, title: String) {
        self.init()
        mbtiLabel.text = title
        imgView.image = image
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.backgroundColor = .black100
        self.layer.borderColor = UIColor.black80.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()
        addSubview(totalStackView)
        totalStackView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }
}
