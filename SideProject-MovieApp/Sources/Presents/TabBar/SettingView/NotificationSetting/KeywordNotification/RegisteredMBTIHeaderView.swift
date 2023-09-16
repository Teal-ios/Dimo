//
//  RegisteredMBTIHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/16.
//

import UIKit

final class RegisteredMBTIHeaderView: UICollectionReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.subtitle3
        label.textColor = .black60
        label.text = "등록한 키워드"
        return label
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black90
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(borderView)
        self.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -16.0),
            borderView.topAnchor.constraint(equalTo: self.topAnchor),
            borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16.0),
            borderView.heightAnchor.constraint(equalToConstant: 1.0),
            
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
