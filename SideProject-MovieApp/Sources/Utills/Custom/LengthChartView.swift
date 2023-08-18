//
//  LengthChartView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/06.
//

import UIKit
import SnapKit

class LengthChartView: BaseView {
    
    let chartContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let chartView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple100
        return view
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .black60
        label.textAlignment = .center
        return label
    }()
    
    let mbtiExplainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black5
        label.textAlignment = .center
        return label
    }()
    
    var mbtiPercent: Double = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(mbtiPercent: Double, mbti: String) {
        self.init()
        self.mbtiPercent = mbtiPercent
        self.mbtiExplainLabel.text = mbti
        self.updateLayoutToMbtiPercent(percent: mbtiPercent)
    }
    
    override func layoutSubviews() {
        self.chartView.layer.cornerRadius = 8
    }
    
    override func setHierarchy() {
        self.addSubview(chartContainView)
        self.addSubview(chartView)
        self.addSubview(percentLabel)
        self.addSubview(mbtiExplainLabel)
    }
    
    override func setupLayout() {
        chartContainView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        chartView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(chartContainView)
            make.height.equalTo(chartContainView.snp.height).multipliedBy(mbtiPercent / 100)
            make.bottom.equalTo(chartContainView.snp.bottom).offset(-24)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(chartView.snp.top).offset(-8)
            make.horizontalEdges.equalTo(chartView)
            make.height.equalTo(16)
        }
        
        mbtiExplainLabel.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(chartContainView)
            make.height.equalTo(16)
        }
    }
}

extension LengthChartView {
    func updateLayoutToMbtiPercent(percent: Double) {
        self.percentLabel.text = String(Int(percent)) + "%"
        self.chartView.snp.removeConstraints()
        chartView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(chartContainView)
            make.height.equalTo(chartContainView.snp.height).multipliedBy(percent / 100)
            make.bottom.equalTo(chartContainView.snp.bottom).offset(-24)
        }
        self.layoutIfNeeded()
    }
}
