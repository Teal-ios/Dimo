//
//  SortActionSheetView.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/16.
//

import UIKit

final class SortActionSheetView: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    
    private let sortStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .black90
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 8.0
        stackView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정렬"
        label.textColor = .white100
        label.font = Font.title3
        return label
    }()
    
    let productionTitleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("작품명", for: .normal)
        button.setTitleColor(.white100, for: .normal)
        button.setTitleColor(.black60, for: .selected)
        button.titleLabel?.font = Font.body2
        return button
    }()
    
    let characterNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("캐릭터명", for: .normal)
        button.setTitleColor(.white100, for: .normal)
        button.setTitleColor(.black60, for: .selected)
        button.titleLabel?.font = Font.body2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setLayoutConstraints()
    }
    
    func addBackgroundViewGesture(_ tapGesture: UITapGestureRecognizer) {
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        sortStackView.addArrangedSubview(titleLabel)
        sortStackView.addArrangedSubview(productionTitleButton)
        sortStackView.addArrangedSubview(characterNameButton)
        
        titleLabel.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        productionTitleButton.heightAnchor.constraint(equalToConstant: 52.0).isActive = true
        characterNameButton.heightAnchor.constraint(equalToConstant: 52.0).isActive = true
        
        backgroundView.addSubview(sortStackView)
        self.addSubview(backgroundView)
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: sortStackView.topAnchor),
            
            sortStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sortStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sortStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            characterNameButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            
            productionTitleButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            
            characterNameButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16.0)
        ])
    }
}
