//
//  OnboardingTextFieldView.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import UIKit
import SnapKit

class OnboardingTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(placeholder: String?) {
        self.init()
        self.layer.cornerRadius = 8
        self.backgroundColor = .black80
        self.placeholder = placeholder
        self.textColor = .white100
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class OnboardingTextFieldView: UIView {
    var tf = OnboardingTextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black80
        self.layer.cornerRadius = 8
        setupLayout()
    }
    
    convenience init(placeholder: String?) {
        self.init()
        tf.placeholder = placeholder
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        let edges: CGFloat = 16
        
        self.addSubview(tf)
        tf.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(edges)
        }
    }
}
