//
//  DigView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/04.
//

import UIKit
import SnapKit

final class DigView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white100
        label.font = Font.title1
        label.text = "Let's DIG!"
        return label
    }()
    
    let buttonContainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let nextButton: OnboardingButton = {
        let button = OnboardingButton(title: "다음", ofSize: 14)
        button.configuration?.baseBackgroundColor = .black80
        return button
    }()
    
    let characterImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white100
        return view
    }()
    
    let characterNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle2
        label.textColor = .black5
        label.textAlignment = .center
        label.text = "정대만"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.textAlignment = .center
        label.text = "더 퍼스트 슬램덩크"
        return label
    }()
    
    let eView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "E_Gray"), title: "외향형")
        view.isUserInteractionEnabled = true
        view.tag = 0
        return view
    }()
    
    let iView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "I_Gray"), title: "내향형")
        view.isUserInteractionEnabled = true
        view.tag = 1
        return view
    }()
    
    let nView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "N_Gray"), title: "직관형")
        view.isUserInteractionEnabled = true
        view.tag = 2
        return view
    }()
    
    let sView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "S_Gray"), title: "감각형")
        view.isUserInteractionEnabled = true
        view.tag = 3
        return view
    }()
    
    let tView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "T_Gray"), title: "사고형")
        view.isUserInteractionEnabled = true
        view.tag = 4
        return view
    }()
    
    let fView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "F_Gray"), title: "감정형")
        view.isUserInteractionEnabled = true
        view.tag = 5
        return view
    }()
    
    let jView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "J_Gray"), title: "판단형")
        view.isUserInteractionEnabled = true
        view.tag = 6
        return view
    }()
    
    let pView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "P_Gray"), title: "인식형")
        view.isUserInteractionEnabled = true
        view.tag = 7
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(characterImageView)
        view.addSubview(characterNicknameLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(totalStackView)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 109 / 2
    }
    
    override func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(buttonContainView)
        self.addSubview(nextButton)
        self.addSubview(scrollView)
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        buttonContainView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(108)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(buttonContainView.snp.top).offset(24)
            make.horizontalEdges.equalTo(buttonContainView)
            make.height.equalTo(48)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(buttonContainView.snp.top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(36)
            make.centerX.equalTo(scrollView)
            make.width.height.equalTo(109)
        }
        
        characterNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(16)
            make.centerX.equalTo(characterImageView)
            make.height.equalTo(19)
            make.horizontalEdges.equalTo(scrollView).inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterNicknameLabel.snp.bottom).offset(4)
            make.centerX.equalTo(characterImageView)
            make.height.equalTo(16)
            make.horizontalEdges.equalTo(scrollView).inset(16)
        }
        
        totalStackView.snp.makeConstraints { make in
            make.height.equalTo(432)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(36)
            make.horizontalEdges.bottom.equalTo(scrollView)
        }
    }
}

//extension DigView {
//    func updateLayoutViewAfter() {
//        characterImageView.clipsToBounds = true
//        characterImageView.layer.cornerRadius = 109 / 2
//    }
//}
