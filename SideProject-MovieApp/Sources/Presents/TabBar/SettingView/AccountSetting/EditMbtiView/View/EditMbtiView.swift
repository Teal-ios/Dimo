//
//  EditMbtiView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import SnapKit

class EditMbtiView: BaseView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.text = "MBTI 변경"
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(lastChangeDayLabel)
        scrollView.addSubview(totalStackView)
        return scrollView
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black60
        label.text = "한 달에 한 번만 변경할 수 있어요"
        return label
    }()
    
    let lastChangeDayLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .black60
        label.text = "마지막 변경일: 2023.05.25"
        return label
    }()
    
    let findMbtiButton: WordLabelButton = {
        let button = WordLabelButton(text: "나의 MBTI를 잘 모르겠어요")
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let mbtiChangeButton: OnboardingButton = {
        let button = OnboardingButton(title: "변경하기", ofSize: 14)
        button.configuration?.baseBackgroundColor = .black80
        button.isEnabled = false
        return button
    }()
    
    let eView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "E_Gray"), title: "외향형")
        view.mbtiButton.setImage(UIImage(named: "E_White"), for: .selected)
        view.isUserInteractionEnabled = true
        view.tag = 0
        
        return view
    }()
    
    let iView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "I_Gray"), title: "내향형")
        view.mbtiButton.setImage(UIImage(named: "I_White"), for: .selected)
        view.isUserInteractionEnabled = true
        view.tag = 1
        return view
    }()
    
    let nView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "N_Gray"), title: "직관형")
        view.mbtiButton.setImage(UIImage(named: "N_White"), for: .selected)
        view.isUserInteractionEnabled = true
        view.tag = 2
        return view
    }()
    
    let sView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "S_Gray"), title: "감각형")
        view.mbtiButton.setImage(UIImage(named: "S_White"), for: .selected)
        view.isUserInteractionEnabled = true
        view.tag = 3
        return view
    }()
    
    let tView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "T_Gray"), title: "사고형")
        view.mbtiButton.setImage(UIImage(named: "T_White"), for: .selected)
        view.isUserInteractionEnabled = true
        view.tag = 4
        return view
    }()
    
    let fView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "F_Gray"), title: "감정형")
        view.mbtiButton.setImage(UIImage(named: "F_White"), for: .selected)
        view.isUserInteractionEnabled = true
        view.tag = 5
        return view
    }()
    
    let jView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "J_Gray"), title: "판단형")
        view.mbtiButton.setImage(UIImage(named: "J_White"), for: .selected)
        view.isUserInteractionEnabled = true
        view.tag = 6
        return view
    }()
    
    let pView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "P_Gray"), title: "인식형")
        view.mbtiButton.setImage(UIImage(named: "P_White"), for: .selected)
        view.isUserInteractionEnabled = true
        view.tag = 7
        return view
    }()
    
    lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            section1StackView, section2StackView, section3StackView, section4StackView
        ])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var section1StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            eView, iView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var section2StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nView, sView
        ])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var section3StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tView, fView
        ])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var section4StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            jView, pView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayoutConstraints()
    }
    
    func checkMbtiChangeButtonValidation(_ isEnabled: Bool) {
        if isEnabled {
            mbtiChangeButton.isEnabled = true
            mbtiChangeButton.configuration?.baseBackgroundColor = UIColor.purple100
        } else {
            mbtiChangeButton.isEnabled = false
            mbtiChangeButton.configuration?.baseBackgroundColor = UIColor.black80
        }
    }
    
    func disableChangeButton() {
        mbtiChangeButton.isEnabled = false
        mbtiChangeButton.configuration?.baseBackgroundColor = UIColor.black80
    }
    
    override func setHierarchy() {
        self.addSubview(headerLabel)
        self.addSubview(scrollView)
        self.addSubview(findMbtiButton)
        self.addSubview(mbtiChangeButton)
    }
    
    private func setLayoutConstraints() {
        let mbtiButtonWidth = (UIScreen.main.bounds.width - 40.0) / 2
        let totalStackViewHeight = (mbtiButtonWidth * 23/42 * 4) + 48.0
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.height.equalTo(48)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(scrollView.snp.top)
            make.height.equalTo(16)
        }
        
        lastChangeDayLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        
        totalStackView.snp.makeConstraints { make in
            make.top.equalTo(lastChangeDayLabel.snp.bottom).offset(44)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(totalStackViewHeight)
        }
        
        findMbtiButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(16)
        }
        
        mbtiChangeButton.snp.makeConstraints { make in
            make.top.equalTo(findMbtiButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(36)
            make.height.equalTo(48)
        }
    }
}

extension EditMbtiView {
    
    func showEButtonState(isSelected: Bool) {
        if isSelected {
            eView.layer.borderColor = UIColor.purple80.cgColor
            eView.imgView.image = UIImage(named: "E_White")
            eView.mbtiLabel.textColor = .black5
            eView.backgroundColor = .black90
        } else {
            eView.layer.borderColor = UIColor.black80.cgColor
            eView.imgView.image = UIImage(named: "E_Gray")
            eView.mbtiLabel.textColor = .black80
            eView.backgroundColor = .black100
        }
    }
    
    func showIButtonState(isSelected: Bool) {
        if isSelected {
            iView.layer.borderColor = UIColor.purple80.cgColor
            iView.imgView.image = UIImage(named: "I_White")
            iView.mbtiLabel.textColor = .black5
            iView.backgroundColor = .black90
        } else {
            iView.layer.borderColor = UIColor.black80.cgColor
            iView.imgView.image = UIImage(named: "I_Gray")
            iView.mbtiLabel.textColor = .black80
            iView.backgroundColor = .black100
        }
    }
    
    func showNButtonState(isSelected: Bool) {
        if isSelected {
            nView.layer.borderColor = UIColor.purple80.cgColor
            nView.imgView.image = UIImage(named: "N_White")
            nView.mbtiLabel.textColor = .black5
            nView.backgroundColor = .black90
        } else {
            nView.layer.borderColor = UIColor.black80.cgColor
            nView.imgView.image = UIImage(named: "N_Gray")
            nView.mbtiLabel.textColor = .black80
            nView.backgroundColor = .black100
        }
    }
    
    func showSButtonState(isSelected: Bool) {
        if isSelected {
            sView.layer.borderColor = UIColor.purple80.cgColor
            sView.imgView.image = UIImage(named: "S_White")
            sView.mbtiLabel.textColor = .black5
            sView.backgroundColor = .black90
        } else {
            sView.layer.borderColor = UIColor.black80.cgColor
            sView.imgView.image = UIImage(named: "S_Gray")
            sView.mbtiLabel.textColor = .black80
            sView.backgroundColor = .black100
        }
    }
    
    func showTButtonState(isSelected: Bool) {
        if isSelected {
            tView.layer.borderColor = UIColor.purple80.cgColor
            tView.imgView.image = UIImage(named: "T_White")
            tView.mbtiLabel.textColor = .black5
            tView.backgroundColor = .black90
        } else {
            tView.layer.borderColor = UIColor.black80.cgColor
            tView.imgView.image = UIImage(named: "T_Gray")
            tView.mbtiLabel.textColor = .black80
            tView.backgroundColor = .black100
        }
    }
    
    func showFButtonState(isSelected: Bool) {
        if isSelected {
            fView.layer.borderColor = UIColor.purple80.cgColor
            fView.imgView.image = UIImage(named: "F_White")
            fView.mbtiLabel.textColor = .black5
            fView.backgroundColor = .black90
        } else {
            fView.layer.borderColor = UIColor.black80.cgColor
            fView.imgView.image = UIImage(named: "F_Gray")
            fView.mbtiLabel.textColor = .black80
            fView.backgroundColor = .black100
        }
    }
    
    func showJButtonState(isSelected: Bool) {
        if isSelected {
            jView.layer.borderColor = UIColor.purple80.cgColor
            jView.imgView.image = UIImage(named: "J_White")
            jView.mbtiLabel.textColor = .black5
            jView.backgroundColor = .black90
        } else {
            jView.layer.borderColor = UIColor.black80.cgColor
            jView.mbtiLabel.textColor = .black80
            jView.backgroundColor = .black100
            jView.imgView.image = UIImage(named: "J_Gray")
        }
    }
    
    func showPButtonState(isSelected: Bool) {
        if isSelected {
            pView.layer.borderColor = UIColor.purple80.cgColor
            pView.imgView.image = UIImage(named: "P_White")
            pView.mbtiLabel.textColor = .black5
            pView.backgroundColor = .black90
        } else {
            pView.layer.borderColor = UIColor.black80.cgColor
            pView.imgView.image = UIImage(named: "P_Gray")
            pView.mbtiLabel.textColor = .black80
            pView.backgroundColor = .black100
        }
    }
}

