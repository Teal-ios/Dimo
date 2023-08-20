//
//  AnalyzeView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/09.
//

import UIKit
import SnapKit

final class AnalyzeView: BaseView {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(titleLabel)
        view.addSubview(chartContainView)
        view.addSubview(chartContainStackView)
        view.addSubview(manyPersonThinkingMbtiContainView)
        view.addSubview(manyPersonThinkingMbtiImageView)
        view.addSubview(manyPersonThinkingMbtiLabel)
        view.addSubview(choiceMbtiExplainContainView)
        view.addSubview(choiceMbtiExplainImageView)
        view.addSubview(choiceMbtiExplainLabel)
        view.addSubview(revoteButton)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.text = "DIMO 유저들의 생각"
        return label
    }()
    
    let chartContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    lazy var chartContainStackView: UIView = {
       let view = UIStackView(arrangedSubviews: [firstChartView, secondChartView, thirdChartView])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 16
        view.backgroundColor = .black90
        return view
    }()
    
    let firstChartView: LengthChartView = {
        let view = LengthChartView(mbtiPercent: 80, mbti: "ESTJ")
        view.backgroundColor = .clear
        return view
    }()
    
    let secondChartView: LengthChartView = {
        let view = LengthChartView(mbtiPercent: 60, mbti: "INFP")
        view.backgroundColor = .clear
        return view
    }()
    
    let thirdChartView: LengthChartView = {
        let view = LengthChartView(mbtiPercent: 30, mbti: "ENFJ")
        view.backgroundColor = .clear
        return view
    }()
    
    let manyPersonThinkingMbtiContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let manyPersonThinkingMbtiImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Badge")
        return view
    }()
    
    let manyPersonThinkingMbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.text = "많은 사람들이 ENTP라고 답변했어요"
        return label
    }()
    
    let choiceMbtiExplainContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let choiceMbtiExplainImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "spoilerCheckOn")
        return view
    }()
    
    let choiceMbtiExplainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.text = "나를 비롯한 00%가 ESFP를 골랐어요"
        return label
    }()
    
    
    let voteButton: OnboardingButton = {
        let button = OnboardingButton(title: "투표하기")
        return button
    }()
    
    let revoteButton: WordLabelButton = {
        let button = WordLabelButton(text: "다시 투표하기")
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartContainView.layer.cornerRadius = 8
        manyPersonThinkingMbtiContainView.layer.cornerRadius = 8
        choiceMbtiExplainContainView.layer.cornerRadius = 8
    }
    
    override func setHierarchy() {
        self.addSubview(scrollView)
    }
    
    override func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(368)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(12)
            make.height.equalTo(19)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        chartContainView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(200)
        }
        
        chartContainStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(chartContainView).inset(78)
            make.verticalEdges.equalTo(chartContainView).inset(24)
        }
        
        manyPersonThinkingMbtiContainView.snp.makeConstraints { make in
            make.top.equalTo(chartContainView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(56)
        }
        
        manyPersonThinkingMbtiImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(manyPersonThinkingMbtiContainView).inset(16)
            make.width.equalTo(24)
        }
        
        manyPersonThinkingMbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(manyPersonThinkingMbtiImageView.snp.trailing).offset(8)
            make.centerY.equalTo(manyPersonThinkingMbtiContainView)
            make.height.equalTo(24)
            make.trailing.equalTo(manyPersonThinkingMbtiContainView.snp.trailing).offset(-16)
        }
        
        choiceMbtiExplainContainView.snp.makeConstraints { make in
            make.top.equalTo(manyPersonThinkingMbtiContainView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(56)
        }
        
        choiceMbtiExplainImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(choiceMbtiExplainContainView).inset(16)
            make.width.equalTo(24)
        }
        
        choiceMbtiExplainLabel.snp.makeConstraints { make in
            make.leading.equalTo(choiceMbtiExplainImageView.snp.trailing).offset(8)
            make.centerY.equalTo(choiceMbtiExplainImageView)
            make.height.equalTo(24)
            make.trailing.equalTo(choiceMbtiExplainContainView.snp.trailing).offset(-16)
        }
        
        revoteButton.snp.makeConstraints { make in
            make.top.equalTo(choiceMbtiExplainContainView.snp.bottom).offset(24)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(92)
            make.height.equalTo(16)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-36)
        }
    }
}
