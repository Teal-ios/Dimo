//
//  JoinTermsView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/29.
//

import UIKit
import SnapKit

final class JoinTermsView: BaseView {
    let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "이용 약관에 동의해 주세요"
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    
    let totalAgreeView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black80.cgColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let totalCheckImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check_gray")
        view.contentMode = .center
        return view
    }()
    
    let totalAgreeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button
        label.textColor = .black60
        label.text = "전체 동의하기"
        return label
    }()
    
    let totalAgreeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let firstCheckImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check_gray")
        view.contentMode = .center
        return view
    }()
    
    let firstAgreementLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .black5
        label.text = "(필수) 만 14세 이상"
        return label
    }()
    
    let firstAgreeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let secondCheckImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check_gray")
        view.contentMode = .center
        return view
    }()
    
    let secondAgreementLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .black5
        label.text = "(필수) DIMO 이용 약관"
        return label
    }()
    
    let secondAgreeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let secondWordButton: WordLabelButton = {
        let button = WordLabelButton(text: "보기")
        return button
    }()
    
    let secondLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black60
        return view
    }()
    
    let thirdCheckImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check_gray")
        view.contentMode = .center
        return view
    }()
    
    let thirdAgreementLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .black5
        label.text = "(필수) 개인정보 수집 및 이용 동의"
        return label
    }()
    
    let thirdWordButton: WordLabelButton = {
        let button = WordLabelButton(text: "보기")
        return button
    }()
    
    let thirdLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black60
        return view
    }()
    
    let thirdAgreeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let fourCheckImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check_gray")
        view.contentMode = .center
        return view
    }()
    
    let fourAgreementLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .black5
        label.text = "(선택) 이벤트 앱 푸시 알림 동의"
        return label
    }()
    
    let fourAgreeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let acceptButton: OnboardingButton = {
        return OnboardingButton(title: "동의하고 계속하기", ofSize: 14)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setHierarchy() {
        self.addSubview(termsLabel)
        self.addSubview(acceptButton)
        self.addSubview(totalAgreeView)
        self.addSubview(totalCheckImageView)
        self.addSubview(totalAgreeLabel)
        self.addSubview(totalAgreeButton)
        self.addSubview(firstCheckImageView)
        self.addSubview(firstAgreementLabel)
        self.addSubview(firstAgreeButton)
        self.addSubview(secondCheckImageView)
        self.addSubview(secondAgreementLabel)
        self.addSubview(secondWordButton)
        self.addSubview(secondAgreeButton)
        self.addSubview(thirdCheckImageView)
        self.addSubview(thirdAgreementLabel)
        self.addSubview(thirdWordButton)
        self.addSubview(thirdAgreeButton)
        self.addSubview(fourCheckImageView)
        self.addSubview(fourAgreementLabel)
        self.addSubview(fourAgreeButton)
        self.addSubview(secondLineView)
        self.addSubview(thirdLineView)
    }
    override func setupLayout() {
        let topLeading: CGFloat = 16
        let buttonHeight: CGFloat = 48
        let bottom: CGFloat = 36
        
        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        acceptButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(buttonHeight)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(bottom)
        }

        totalAgreeView.snp.makeConstraints { make in
            make.top.equalTo(termsLabel.snp.bottom).offset(52)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
        
        totalCheckImageView.snp.makeConstraints { make in
            make.centerY.equalTo(totalAgreeView)
            make.leading.equalTo(totalAgreeView).offset(8)
            make.width.height.equalTo(24)
        }
        
        totalAgreeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalAgreeView)
            make.leading.equalTo(totalCheckImageView.snp.trailing).offset(8)
            make.trailing.equalTo(totalAgreeView.snp.trailing).inset(8)
            make.height.equalTo(24)
        }
        
        totalAgreeButton.snp.makeConstraints { make in
            make.edges.equalTo(totalAgreeView)
        }
        
        firstCheckImageView.snp.makeConstraints { make in
            make.top.equalTo(totalAgreeView.snp.bottom).offset(30)
            make.width.height.equalTo(24)
            make.leading.equalTo(totalAgreeView.snp.leading)
        }
        
        firstAgreementLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstCheckImageView)
            make.leading.equalTo(firstCheckImageView.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-40)
        }
        
        firstAgreeButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(firstAgreementLabel)
            make.leading.equalTo(firstCheckImageView.snp.leading)
        }
        
        secondCheckImageView.snp.makeConstraints { make in
            make.top.equalTo(firstCheckImageView.snp.bottom).offset(28)
            make.width.height.equalTo(24)
            make.leading.equalTo(totalAgreeView.snp.leading)
        }
        
        secondAgreementLabel.snp.makeConstraints { make in
            make.centerY.equalTo(secondCheckImageView)
            make.leading.equalTo(secondCheckImageView.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-40)
        }
        
        secondWordButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-24)
            make.width.equalTo(24)
            make.centerY.equalTo(secondCheckImageView)
            make.height.equalTo(16)
        }
        
        secondAgreeButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(secondAgreementLabel)
            make.leading.equalTo(secondCheckImageView.snp.leading)
        }
        
        thirdCheckImageView.snp.makeConstraints { make in
            make.top.equalTo(secondCheckImageView.snp.bottom).offset(28)
            make.width.height.equalTo(24)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        thirdAgreementLabel.snp.makeConstraints { make in
            make.centerY.equalTo(thirdCheckImageView)
            make.leading.equalTo(thirdCheckImageView.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-40)
        }
        
        thirdWordButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24)
            make.width.equalTo(24)
            make.centerY.equalTo(thirdCheckImageView)
            make.height.equalTo(16)
        }
        
        thirdAgreeButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(thirdAgreementLabel)
            make.leading.equalTo(thirdCheckImageView.snp.leading)
        }
        
        fourCheckImageView.snp.makeConstraints { make in
            make.top.equalTo(thirdCheckImageView.snp.bottom).offset(28)
            make.width.height.equalTo(24)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        fourAgreementLabel.snp.makeConstraints { make in
            make.centerY.equalTo(fourCheckImageView)
            make.leading.equalTo(fourCheckImageView.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-40)
        }
        
        fourAgreeButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(fourAgreementLabel)
            make.leading.equalTo(fourCheckImageView.snp.leading)
        }
        
        secondLineView.snp.makeConstraints { make in
            make.top.equalTo(secondWordButton.snp.bottom)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(20)
            make.height.equalTo(1)
        }
        
        thirdLineView.snp.makeConstraints { make in
            make.top.equalTo(thirdWordButton.snp.bottom)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(20)
            make.height.equalTo(1)
        }
    }
}
