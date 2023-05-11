//
//  JoinMbtiView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/06.
//

import UIKit
import SnapKit

class JoinMbtiView: BaseView {
    
    private var cellSelectArr: [Bool] = [false, false, false, false, false, false, false, false]

    
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
        addSubview(totalStackView)
        addSubview(findMbtiButton)
        addSubview(nextButton)
        
        let eViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(eViewTapped))
        let iViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(iViewTapped))
        let nViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(nViewTapped))
        let sViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(sViewTapped))
        let tViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(tViewTapped))
        let fViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(fViewTapped))
        let jViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(jViewTapped))
        let pViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(pViewTapped))

        self.eView.addGestureRecognizer(eViewTapGesture)
        self.iView.addGestureRecognizer(iViewTapGesture)
        self.nView.addGestureRecognizer(nViewTapGesture)
        self.sView.addGestureRecognizer(sViewTapGesture)
        self.tView.addGestureRecognizer(tViewTapGesture)
        self.fView.addGestureRecognizer(fViewTapGesture)
        self.jView.addGestureRecognizer(jViewTapGesture)
        self.pView.addGestureRecognizer(pViewTapGesture)

        
    }
    
    func snapkit() {
        headerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.height.equalTo(48)
        }
        
        totalStackView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
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

extension JoinMbtiView {
        
    @objc
    func eViewTapped() {
        if cellSelectArr[0] == false && cellSelectArr[1] == false {
            eView.layer.borderColor = UIColor.purple80.cgColor
            eView.mbtiLabel.textColor = .white100
            eView.backgroundColor = .black90
            cellSelectArr[0] = true

        } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
            eView.layer.borderColor = UIColor.black80.cgColor
            eView.mbtiLabel.textColor = .black80
            eView.backgroundColor = .black100
            cellSelectArr[0] = false
        } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
            eView.layer.borderColor = UIColor.purple80.cgColor
            eView.mbtiLabel.textColor = .white100
            eView.backgroundColor = .black90
            
            iView.layer.borderColor = UIColor.black80.cgColor
            iView.mbtiLabel.textColor = .black80
            iView.backgroundColor = .black100
            cellSelectArr[0] = true
            cellSelectArr[1] = false
        }
    }
    
    @objc
    func iViewTapped() {
        if cellSelectArr[0] == false && cellSelectArr[1] == false {
            iView.layer.borderColor = UIColor.purple80.cgColor
            iView.mbtiLabel.textColor = .white100
            iView.backgroundColor = .black90
            cellSelectArr[1] = true

        } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
            eView.layer.borderColor = UIColor.black80.cgColor
            eView.mbtiLabel.textColor = .black80
            eView.backgroundColor = .black100
            
            iView.layer.borderColor = UIColor.purple80.cgColor
            iView.mbtiLabel.textColor = .white100
            iView.backgroundColor = .black90
            cellSelectArr[0] = false
            cellSelectArr[1] = true
        } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
            iView.layer.borderColor = UIColor.black80.cgColor
            iView.mbtiLabel.textColor = .black80
            iView.backgroundColor = .black100
            cellSelectArr[1] = false
        }
    }
    
    @objc
    func nViewTapped() {
        if cellSelectArr[2] == false && cellSelectArr[3] == false {
            nView.layer.borderColor = UIColor.purple80.cgColor
            nView.mbtiLabel.textColor = .white100
            nView.backgroundColor = .black90
            cellSelectArr[2] = true

        } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
            nView.layer.borderColor = UIColor.black80.cgColor
            nView.mbtiLabel.textColor = .black80
            nView.backgroundColor = .black100
            
            cellSelectArr[2] = false
        } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
            nView.layer.borderColor = UIColor.purple80.cgColor
            nView.mbtiLabel.textColor = .white100
            nView.backgroundColor = .black90
            
            sView.layer.borderColor = UIColor.black80.cgColor
            sView.mbtiLabel.textColor = .black80
            sView.backgroundColor = .black100
            cellSelectArr[2] = true
            cellSelectArr[3] = false
        }
    }
    
    @objc
    func sViewTapped() {
        if cellSelectArr[2] == false && cellSelectArr[3] == false {
            sView.layer.borderColor = UIColor.purple80.cgColor
            sView.mbtiLabel.textColor = .white100
            sView.backgroundColor = .black90
            cellSelectArr[3] = true

        } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
            nView.layer.borderColor = UIColor.black80.cgColor
            nView.mbtiLabel.textColor = .black80
            nView.backgroundColor = .black100
            
            sView.layer.borderColor = UIColor.purple80.cgColor
            sView.mbtiLabel.textColor = .white100
            sView.backgroundColor = .black90
            cellSelectArr[2] = false
            cellSelectArr[3] = true
        } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
            sView.layer.borderColor = UIColor.black80.cgColor
            sView.mbtiLabel.textColor = .black80
            sView.backgroundColor = .black100
            cellSelectArr[3] = false
        }
    }
    
    @objc
    func tViewTapped() {
        if cellSelectArr[4] == false && cellSelectArr[5] == false {
            tView.layer.borderColor = UIColor.purple80.cgColor
            tView.mbtiLabel.textColor = .white100
            tView.backgroundColor = .black90
            cellSelectArr[4] = true

        } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
            tView.layer.borderColor = UIColor.black80.cgColor
            tView.mbtiLabel.textColor = .black80
            tView.backgroundColor = .black100
            
            cellSelectArr[4] = false
        } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
            tView.layer.borderColor = UIColor.purple80.cgColor
            tView.mbtiLabel.textColor = .white100
            tView.backgroundColor = .black90
            
            fView.layer.borderColor = UIColor.black80.cgColor
            fView.mbtiLabel.textColor = .black80
            fView.backgroundColor = .black100
            cellSelectArr[4] = true
            cellSelectArr[5] = false
        }
    }
    
    @objc
    func fViewTapped() {
        if cellSelectArr[4] == false && cellSelectArr[5] == false {
            fView.layer.borderColor = UIColor.purple80.cgColor
            fView.mbtiLabel.textColor = .white100
            fView.backgroundColor = .black90
            cellSelectArr[5] = true

        } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
            tView.layer.borderColor = UIColor.black80.cgColor
            tView.mbtiLabel.textColor = .black80
            tView.backgroundColor = .black100
            
            fView.layer.borderColor = UIColor.purple80.cgColor
            fView.mbtiLabel.textColor = .white100
            fView.backgroundColor = .black90
            cellSelectArr[4] = false
            cellSelectArr[5] = true
        } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
            fView.layer.borderColor = UIColor.black80.cgColor
            fView.mbtiLabel.textColor = .black80
            fView.backgroundColor = .black100
            cellSelectArr[5] = false
        }
    }
    
    @objc
    func jViewTapped() {
        if cellSelectArr[6] == false && cellSelectArr[7] == false {
            jView.layer.borderColor = UIColor.purple80.cgColor
            jView.mbtiLabel.textColor = .white100
            jView.backgroundColor = .black90
            cellSelectArr[6] = true

        } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
            jView.layer.borderColor = UIColor.black80.cgColor
            jView.mbtiLabel.textColor = .black80
            jView.backgroundColor = .black100
            
            cellSelectArr[6] = false
        } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
            jView.layer.borderColor = UIColor.purple80.cgColor
            jView.mbtiLabel.textColor = .white100
            jView.backgroundColor = .black90
            
            pView.layer.borderColor = UIColor.black80.cgColor
            pView.mbtiLabel.textColor = .black80
            pView.backgroundColor = .black100
            cellSelectArr[6] = true
            cellSelectArr[7] = false
        }
    }
    
    @objc
    func pViewTapped() {
        if cellSelectArr[6] == false && cellSelectArr[7] == false {
            pView.layer.borderColor = UIColor.purple80.cgColor
            pView.mbtiLabel.textColor = .white100
            pView.backgroundColor = .black90
            cellSelectArr[7] = true

        } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
            jView.layer.borderColor = UIColor.black80.cgColor
            jView.mbtiLabel.textColor = .black80
            jView.backgroundColor = .black100
            
            pView.layer.borderColor = UIColor.purple80.cgColor
            pView.mbtiLabel.textColor = .white100
            pView.backgroundColor = .black90
            cellSelectArr[6] = false
            cellSelectArr[7] = true
        } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
            pView.layer.borderColor = UIColor.black80.cgColor
            pView.mbtiLabel.textColor = .black80
            pView.backgroundColor = .black100
            cellSelectArr[7] = false
        }
    }
}


