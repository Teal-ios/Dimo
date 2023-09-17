//
//  KeywordSearchTextField.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/02.
//

import UIKit

final class KeywordSearchTextField: UITextField {
    
    let searchContainView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .black90
        return view
    }()
    
    let searchImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Search")
        return view
    }()
    
    let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "작품명 / 캐릭터명을 입력해 주세요"
        return tf
    }()
    
    init(placeHolder: String) {
        self.searchTextField.placeholder = placeHolder
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setHierarchy()
        self.setupLayout()
        self.addTextFieldAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        self.addSubview(searchContainView)
        self.addSubview(searchImageView)
        self.addSubview(searchTextField)
    }
    
    func setupLayout() {
        searchContainView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(52)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.centerY.equalTo(searchContainView)
            make.leading.equalTo(searchContainView.snp.leading).offset(16)
            make.height.width.equalTo(20)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(8)
            make.centerY.equalTo(searchContainView)
            make.trailing.equalTo(searchContainView.snp.trailing).offset(-16)
            make.verticalEdges.equalTo(searchContainView)
        }
    }
}

extension KeywordSearchTextField {
    
    func addTextFieldAction() {
        searchTextField.addAction(UIAction(handler: { _ in
            guard let isTextFieldEmpty = self.searchTextField.text?.isEmpty else { return }
            
            if isTextFieldEmpty {
                self.searchImageView.image = UIImage(named: "Search")
            } else {
                self.searchImageView.image = UIImage(named: "Search_On")
            }
        }), for: .editingChanged)
    }
}
