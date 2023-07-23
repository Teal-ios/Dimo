//
//  JoinMbtiView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/06.
//

import UIKit
import SnapKit

class JoinMbtiView: BaseView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.text = "당신의 MBTI는 무엇인가요?"
        return label
    }()
    
    let findMbtiButton: WordLabelButton = {
        let button = WordLabelButton(text: "나의 MBTI를 잘 모르겠어요")
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let nextButton: OnboardingButton = {
        let button = OnboardingButton(title: "다음", ofSize: 14)
        button.configuration?.baseBackgroundColor = .black80
        return button
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
        hierarchy()
        snapkit()
    }
    
    func hierarchy() {
        
        addSubview(headerLabel)
        addSubview(totalStackView)
        addSubview(findMbtiButton)
        addSubview(nextButton)

        
    }
    
    func snapkit() {
        headerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.height.equalTo(29)
        }
        
        totalStackView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(36)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(140)
        }
        
        findMbtiButton.snp.makeConstraints { make in
            make.top.equalTo(totalStackView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(findMbtiButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(36)
        }
    }
}


