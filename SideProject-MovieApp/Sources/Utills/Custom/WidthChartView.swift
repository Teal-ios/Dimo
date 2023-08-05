//
//  WidthChartView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/05.
//

import UIKit
import SnapKit

class WidthChartView: BaseView {
    let chartContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black80
        return view
    }()
    
    let leftChartView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple100
        return view
    }()
    
    let rightChartView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple100
        return view
    }()
    
    let leftChartMbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black5
        label.textAlignment = .left
        return label
    }()
    
    let leftChartPercentLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .purple40
        label.textAlignment = .right
        return label
    }()
    
    let rightChartMbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black5
        label.textAlignment = .right
        return label
    }()
    
    let rightChartPercentLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .purple40
        label.textAlignment = .left
        return label
    }()
    
    var mbtiPercent: Double = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(mbtiPercent: Double, leftMbtiText: String, rightMbtiText: String) {
        self.init()
        self.mbtiPercent = mbtiPercent
        self.leftChartMbtiLabel.text = leftMbtiText
        self.rightChartMbtiLabel.text = rightMbtiText
        self.updateLayoutToMbtiPercent(percent: mbtiPercent)
    }
    
    override func layoutSubviews() {
        self.chartContainView.layer.cornerRadius = 8
        self.leftChartView.layer.cornerRadius = 8
        self.rightChartView.layer.cornerRadius = 8
    }
    
    override func setHierarchy() {
        self.addSubview(chartContainView)
        self.addSubview(leftChartView)
        self.addSubview(leftChartMbtiLabel)
        self.addSubview(leftChartPercentLabel)
        self.addSubview(rightChartView)
        self.addSubview(rightChartMbtiLabel)
        self.addSubview(rightChartPercentLabel)
    }
    
    override func setupLayout() {
        chartContainView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        leftChartView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(chartContainView)
            make.width.equalTo(chartContainView.snp.width).multipliedBy(mbtiPercent / 100)
        }
        
        leftChartMbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftChartView.snp.leading).offset(16)
            make.centerY.equalTo(leftChartView)
            make.width.equalTo(12)
            make.height.equalTo(18)
        }
        
        leftChartPercentLabel.snp.makeConstraints { make in
            make.trailing.equalTo(leftChartView.snp.trailing).offset(-16)
            make.centerY.equalTo(leftChartView)
            make.width.equalTo(32)
            make.height.equalTo(18)
        }
        
        rightChartView.snp.makeConstraints { make in
            make.leading.equalTo(leftChartView.snp.trailing)
            make.verticalEdges.equalTo(chartContainView)
            make.width.equalTo(chartContainView.snp.width).multipliedBy((100 - mbtiPercent) / 100)
        }
        
        rightChartMbtiLabel.snp.makeConstraints { make in
            make.trailing.equalTo(rightChartView.snp.trailing).offset(-16)
            make.centerY.verticalEdges.equalTo(rightChartView)
            make.width.equalTo(12)
            make.height.equalTo(18)
        }
        
        rightChartPercentLabel.snp.makeConstraints { make in
            make.leading.equalTo(rightChartView.snp.leading).offset(16)
            make.centerY.equalTo(rightChartView)
            make.width.equalTo(32)
            make.height.equalTo(18)
        }
    }
}

extension WidthChartView {
    func leftChartViewHidden() {
        self.leftChartView.backgroundColor = .black80
        self.leftChartMbtiLabel.text = ""
        self.leftChartPercentLabel.text = ""
    }
    
    func rightCharViewHidden() {
        self.rightChartView.backgroundColor = .black80
        self.rightChartMbtiLabel.text = ""
        self.rightChartPercentLabel.text = ""
    }
    
    func updateLayoutToMbtiPercent(percent: Double) {
        self.leftChartPercentLabel.text = String(Int(mbtiPercent)) + "%"
        self.rightChartPercentLabel.text = String(Int(100 - mbtiPercent)) + "%"
        self.leftChartView.snp.removeConstraints()
        self.leftChartView.snp.remakeConstraints { make in
            make.leading.verticalEdges.equalTo(chartContainView)
            make.width.equalTo(chartContainView.snp.width).multipliedBy(mbtiPercent / 100)
        }
        self.rightChartView.snp.removeConstraints()
        self.rightChartView.snp.remakeConstraints { make in
            make.leading.equalTo(leftChartView.snp.trailing)
            make.verticalEdges.equalTo(chartContainView)
            make.width.equalTo(chartContainView.snp.width).multipliedBy((100 - mbtiPercent) / 100)
        }
        
        if mbtiPercent > 50 {
            self.rightCharViewHidden()
        } else {
            self.leftChartViewHidden()
        }
        self.layoutIfNeeded()
    }
}
