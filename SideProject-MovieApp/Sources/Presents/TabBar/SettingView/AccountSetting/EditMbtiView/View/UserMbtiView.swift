//
//  UserMbtiView.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/20.
//

import UIKit

final class UserMbtiView: BaseView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.text = "MBTI 변경"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black60
        label.text = "한 달에 한 번만 변경할 수 있어요"
        return label
    }()
    
    private let lastChangeDayLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .black60
        label.text = "마지막 변경일: 2023.05.25"
        return label
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private let firstSectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let secondSectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    // E or I
    let energyView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(), title: "")
        view.mbtiButton.setImage(UIImage(), for: .normal)
        view.isUserInteractionEnabled = true
        view.tag = 0
        
        return view
    }()
    
    // N or S
    let informationView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(), title: "")
        view.mbtiButton.setImage(UIImage(), for: .normal)
        view.isUserInteractionEnabled = true
        view.tag = 1
        return view
    }()
    
    // T or F
    let decisionView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(), title: "")
        view.mbtiButton.setImage(UIImage(), for: .normal)
        view.isUserInteractionEnabled = true
        view.tag = 2
        return view
    }()
    
    // J or P
    let lifeStyleView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(), title: "")
        view.mbtiButton.setImage(UIImage(), for: .normal)
        view.isUserInteractionEnabled = true
        view.tag = 3
        return view
    }()
    
    
    override func setHierarchy() {
        firstSectionStackView.addArrangedSubview(energyView)
        firstSectionStackView.addArrangedSubview(informationView)
        secondSectionStackView.addArrangedSubview(decisionView)
        secondSectionStackView.addArrangedSubview(lifeStyleView)
        totalStackView.addArrangedSubview(firstSectionStackView)
        totalStackView.addArrangedSubview(secondSectionStackView)
        self.addSubview(headerLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(lastChangeDayLabel)
        self.addSubview(totalStackView)
    }
    
    override func setupLayout() {
        let mbtiButtonWidth = (UIScreen.main.bounds.width - 40.0) / 2
        let totalStackViewHeight = (mbtiButtonWidth * 23/42 * 2) + 48.0
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(48)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.leading)
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        
        lastChangeDayLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.leading)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        
        totalStackView.snp.makeConstraints { make in
            make.top.equalTo(lastChangeDayLabel.snp.bottom).offset(44)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(totalStackViewHeight)
        }
    }
}

extension UserMbtiView {
    
    func setMbtiEnergyView(image: UIImage?, title: String) {
        energyView.imgView.image = image
        energyView.mbtiLabel.text = title
        energyView.mbtiLabel.textColor = .black5
    }
    
    func setMbtiInformationView(image: UIImage?, title: String) {
        informationView.imgView.image = image
        informationView.mbtiLabel.text = title
        informationView.mbtiLabel.textColor = .black5
    }
    
    func setMbtiDecisionView(image: UIImage?, title: String) {
        decisionView.imgView.image = image
        decisionView.mbtiLabel.text = title
        decisionView.mbtiLabel.textColor = .black5
    }
    
    func setMbtiLifeStyleView(image: UIImage?, title: String) {
        lifeStyleView.imgView.image = image
        lifeStyleView.mbtiLabel.text = title
        lifeStyleView.mbtiLabel.textColor = .black5
    }
    
    func setLastChangeDate(_ text: String) {
        lastChangeDayLabel.text = text
    }
}
