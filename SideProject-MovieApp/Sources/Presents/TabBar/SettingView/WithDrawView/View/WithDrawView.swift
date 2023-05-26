//
//  WithDrawView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import SnapKit

class WithDrawView: BaseView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.text = "정말 떠나시나요?"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.numberOfLines = 0
        label.text = "탈퇴 이유를 알려 주시면 서비스 개선에 적극적으로 반영하겠습니다. 앞으로 더 나은 DIMO가 될 수 있도록 노력할게요!"
        return label
    }()
    
    let contentView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "콘텐츠 불만족")
        return view
    }()
    
    let serviceView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "서비스 불만족")
        return view
    }()
    
    let appView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "앱 불만족")
        return view
    }()
    
    let frequencyView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "사용 빈도 낮음")
        return view
    }()
    
    let interestView: DrawButtonLabel = {
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
        return OnboardingButton(title: "변경하기", ofSize: 14)
    }()

    
    override func setHierarchy() {
        self.addSubview(headerLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(contentView)
        self.addSubview(serviceView)
        self.addSubview(appView)
        self.addSubview(frequencyView)
        self.addSubview(interestView)
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
            make.width.equalTo(200)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(42)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        serviceView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        appView.snp.makeConstraints { make in
            make.top.equalTo(serviceView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        frequencyView.snp.makeConstraints { make in
            make.top.equalTo(appView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        interestView.snp.makeConstraints { make in
            make.top.equalTo(frequencyView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        etcView.snp.makeConstraints { make in
            make.top.equalTo(interestView.snp.bottom).offset(24)
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
