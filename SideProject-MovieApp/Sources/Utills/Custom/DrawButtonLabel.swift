//
//  drawButtonLabel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import SnapKit

class DrawButtonLabel: BaseView {
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "NotChoice"), for: .normal)
        button.setImage(UIImage(named: "Choice"), for: .selected)
        return button
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .black5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCheckButtonAction()
    }
    
    convenience init(text: String) {
        self.init()
        textLabel.text = text
    }
    
    override func setHierarchy() {
        self.addSubview(checkButton)
        self.addSubview(textLabel)
    }
    
    override func setupLayout() {
        checkButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide)
            make.height.width.equalTo(24)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(8)
            make.verticalEdges.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func addCheckButtonAction() {
        let action = UIAction { action in
            self.checkButton.isSelected.toggle()
        }
        checkButton.addAction(action, for: .touchUpInside)
    }
}
