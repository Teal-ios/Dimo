//
//  WithDrawView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit

class WithdrawView: BaseView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.text = "정말 떠나시나요?"
        return label
    }()
    
    let cryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cry")
        return imageView
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.numberOfLines = 0
        label.text = "탈퇴 이유를 알려 주시면 서비스 개선에 적극적으로 반영하겠습니다. 앞으로 더 나은 DIMO가 될 수 있도록 노력할게요!"
        return label
    }()
    
    let contentsDissatisfactionView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "콘텐츠 불만족")
        return view
    }()
    
    let serviceDissatisfactionView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "서비스 불만족")
        return view
    }()
    
    let appDissatisfactionView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "앱 불만족")
        return view
    }()
    
    let lowFrequencyView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "사용 빈도 낮음")
        return view
    }()
    
    let losingInterestView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "단순 흥미 하락")
        return view
    }()
    
    let etcView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "기타")
        return view
    }()
    
    let withdrawalReasonTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .black90
        view.layer.cornerRadius = 8
        view.text = "탈퇴 사유를 작성해 주세요"
        view.textColor = .black80
        view.contentInset = UIEdgeInsets(top: 14.0, left: 16.0, bottom: 14.0, right: 16.0)
        view.font = UIFont.suitFont(ofSize: 16, weight: .Medium)
        return view
    }()
    
    let maxTextLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 100자"
        label.font = Font.caption
        label.textColor = .black60
        return label
    }()
    
    let withdrawButton: OnboardingButton = {
        return OnboardingButton(title: "탈퇴하기", ofSize: 14)
    }()
    
    override func setHierarchy() {
        self.addSubview(headerLabel)
        self.addSubview(cryImageView)
        self.addSubview(subtitleLabel)
        self.addSubview(contentsDissatisfactionView)
        self.addSubview(serviceDissatisfactionView)
        self.addSubview(appDissatisfactionView)
        self.addSubview(lowFrequencyView)
        self.addSubview(losingInterestView)
        self.addSubview(etcView)
        self.addSubview(withdrawButton)
        self.addSubview(withdrawalReasonTextView)
        self.addSubview(maxTextLabel)
    }
    
    override func setupLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(16)
            make.height.equalTo(28)
        }
        
        cryImageView.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.trailing).offset(8)
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.width.equalTo(34.3)
            make.height.equalTo(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
//            make.height.equalTo(42)
        }
        
        contentsDissatisfactionView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        serviceDissatisfactionView.snp.makeConstraints { make in
            make.top.equalTo(contentsDissatisfactionView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        appDissatisfactionView.snp.makeConstraints { make in
            make.top.equalTo(serviceDissatisfactionView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        lowFrequencyView.snp.makeConstraints { make in
            make.top.equalTo(appDissatisfactionView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        losingInterestView.snp.makeConstraints { make in
            make.top.equalTo(lowFrequencyView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        etcView.snp.makeConstraints { make in
            make.top.equalTo(losingInterestView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        maxTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(withdrawButton.snp.top).offset(-8)
            make.height.equalTo(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        withdrawalReasonTextView.snp.makeConstraints { make in
            make.bottom.equalTo(maxTextLabel.snp.top).offset(-4)
            make.top.equalTo(etcView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}

extension WithdrawView {
    
    func setupTextView(_ isEditing: Bool) {
        if isEditing {
            withdrawalReasonTextView.text = ""
            withdrawalReasonTextView.textColor = .white100
        } else {
            withdrawalReasonTextView.text = "탈퇴 사유를 작성해 주세요"
            withdrawalReasonTextView.textColor = .black80
        }
    }
    
    func enableWithdrawButton(_ isWithdrawable: Bool) {
        withdrawButton.isEnabled = isWithdrawable
        
        if isWithdrawable {
            withdrawButton.configuration?.baseBackgroundColor = .purple100
        } else {
            withdrawButton.configuration?.baseBackgroundColor = .black80
        }
    }
    
    func setupWithdrawReasonButton(reason: WithdrawViewModel.WithdrawReason) {
        switch reason {
        case .contentsDissatisfaction(let isSelected):
            contentsDissatisfactionView.checkButton.isSelected = isSelected
            serviceDissatisfactionView.checkButton.isSelected  = false
            appDissatisfactionView.checkButton.isSelected = false
            lowFrequencyView.checkButton.isSelected = false
            losingInterestView.checkButton.isSelected = false
            etcView.checkButton.isSelected = false
        case .serviceDissatisfaction(let isSelected):
            contentsDissatisfactionView.checkButton.isSelected  = false
            serviceDissatisfactionView.checkButton.isSelected = isSelected
            appDissatisfactionView.checkButton.isSelected = false
            lowFrequencyView.checkButton.isSelected = false
            losingInterestView.checkButton.isSelected = false
            etcView.checkButton.isSelected = false
        case .appDissatisfaction(let isSelected):
            contentsDissatisfactionView.checkButton.isSelected  = false
            serviceDissatisfactionView.checkButton.isSelected  = false
            appDissatisfactionView.checkButton.isSelected = isSelected
            lowFrequencyView.checkButton.isSelected = false
            losingInterestView.checkButton.isSelected = false
            etcView.checkButton.isSelected = false
        case .lowFrequency(let isSelected):
            contentsDissatisfactionView.checkButton.isSelected  = false
            serviceDissatisfactionView.checkButton.isSelected  = false
            appDissatisfactionView.checkButton.isSelected = false
            lowFrequencyView.checkButton.isSelected = isSelected
            losingInterestView.checkButton.isSelected = false
            etcView.checkButton.isSelected = false
        case .losingInterest(let isSelected):
            contentsDissatisfactionView.checkButton.isSelected  = false
            serviceDissatisfactionView.checkButton.isSelected  = false
            appDissatisfactionView.checkButton.isSelected = false
            lowFrequencyView.checkButton.isSelected = false
            losingInterestView.checkButton.isSelected = isSelected
            etcView.checkButton.isSelected = false
        case .etc(let isSelected):
            contentsDissatisfactionView.checkButton.isSelected  = false
            serviceDissatisfactionView.checkButton.isSelected  = false
            appDissatisfactionView.checkButton.isSelected = false
            lowFrequencyView.checkButton.isSelected = false
            losingInterestView.checkButton.isSelected = false
            etcView.checkButton.isSelected = isSelected
        }
    }
}
