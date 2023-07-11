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
    
    let nextButton: OnboardingButton = {
        let button = OnboardingButton(title: "다음", ofSize: 14)
        button.configuration?.baseBackgroundColor = .black80
        return button
    }()
    
    let eView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "E"), title: "외향형")
        view.isUserInteractionEnabled = true
        view.tag = 0
        
        return view
    }()
    
    let iView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "I"), title: "내향형")
        view.isUserInteractionEnabled = true
        view.tag = 1
        return view
    }()
    
    let nView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "N"), title: "직관형")
        view.isUserInteractionEnabled = true
        view.tag = 2
        return view
    }()
    
    let sView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "S"), title: "감각형")
        view.isUserInteractionEnabled = true
        view.tag = 3
        return view
    }()
    
    let tView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "T"), title: "사고형")
        view.isUserInteractionEnabled = true
        view.tag = 4
        return view
    }()
    
    let fView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "F"), title: "감정형")
        view.isUserInteractionEnabled = true
        view.tag = 5
        return view
    }()
    
    let jView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "J"), title: "판단형")
        view.isUserInteractionEnabled = true
        view.tag = 6
        return view
    }()
    
    let pView: MbtiAlphabetView = {
        let view = MbtiAlphabetView(image: UIImage(named: "P"), title: "인식형")
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
        addSubview(subTitleLabel)
        addSubview(lastChangeDayLabel)
        addSubview(totalStackView)
        addSubview(findMbtiButton)
        addSubview(nextButton)

        
    }
    
    func snapkit() {
        headerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.height.equalTo(48)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        
        lastChangeDayLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            make.height.equalTo(16)
        }
        
        totalStackView.snp.makeConstraints { make in
            make.top.equalTo(lastChangeDayLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(140)
        }
        
        findMbtiButton.snp.makeConstraints { make in
            make.top.equalTo(totalStackView.snp.bottom).offset(16)
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


