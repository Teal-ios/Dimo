//
//  ReportView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import UIKit
import SnapKit

final class ReportView: BaseView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.text = "신고 사유를 알려주세요."
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.numberOfLines = 0
        label.text = "아래 사유 중 하나를 선택해 주세요. 신고 내용을 검토해 필요 시 제한 조치 하겠습니다. 쾌적한 DIMO가 되기 위해 노력할게요."
        return label
    }()
    
    let slangUsingView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "비속어 사용")
        return view
    }()
    
    let spoilerView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "스포일러")
        return view
    }()
    
    let lewdnessOrViolenceView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "음란 폭력")
        return view
    }()
    
    let promotionView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "홍보")
        return view
    }()
    
    let politicsOrReligionView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "정치·종교적 발언")
        return view
    }()
    
    let lieInfoView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "거짓 정보")
        return view
    }()
    
    let etcView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "기타")
        return view
    }()
    
    let reportReasonTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .black90
        view.layer.cornerRadius = 8
        view.text = "안녕하세요 디모를 사랑하는 사람입니다"
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
    
    let reportButton: OnboardingButton = {
        return OnboardingButton(title: "신고하기", ofSize: 14)
    }()
    
    override func setHierarchy() {
        self.addSubview(headerLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(slangUsingView)
        self.addSubview(spoilerView)
        self.addSubview(lewdnessOrViolenceView)
        self.addSubview(promotionView)
        self.addSubview(politicsOrReligionView)
        self.addSubview(lieInfoView)
        self.addSubview(etcView)
        self.addSubview(reportButton)
        self.addSubview(reportReasonTextView)
        self.addSubview(maxTextLabel)
    }
    
    override func setupLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(16)
            make.height.equalTo(28)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(42)
        }
        
        slangUsingView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        spoilerView.snp.makeConstraints { make in
            make.top.equalTo(slangUsingView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        lewdnessOrViolenceView.snp.makeConstraints { make in
            make.top.equalTo(spoilerView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        promotionView.snp.makeConstraints { make in
            make.top.equalTo(lewdnessOrViolenceView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        politicsOrReligionView.snp.makeConstraints { make in
            make.top.equalTo(promotionView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        lieInfoView.snp.makeConstraints { make in
            make.top.equalTo(politicsOrReligionView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        etcView.snp.makeConstraints { make in
            make.top.equalTo(lieInfoView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        reportButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        maxTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(reportButton.snp.top).offset(-8)
            make.height.equalTo(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        reportReasonTextView.snp.makeConstraints { make in
            make.bottom.equalTo(maxTextLabel.snp.top).offset(-4)
            make.top.equalTo(etcView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
