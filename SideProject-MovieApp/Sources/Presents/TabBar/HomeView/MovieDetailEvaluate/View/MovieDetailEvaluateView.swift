//
//  MovieDetailEvaluate.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import UIKit
import SnapKit

final class MovieDetailEvaluateView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black100
        view.alpha = 0.35
        return view
    }()
    
    let baseCategoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        return view
    }()
    
    let backgroundButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.title3
        label.text = "평가하기"
        label.textAlignment = .left
        return label
    }()
    
    let totalChoiceButtonContainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let goodChoiceContainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let goodChoiceImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Good_Nonselect")
        return view
    }()
    
    let goodChoiceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.caption
        label.text = "맘에 들어요"
        label.textColor = .black60
        return label
    }()
    
    let goodChoiceButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let badChoiceContainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let badChoiceImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Bad_Nonselect")
        return view
    }()
    
    let badChoiceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.caption
        label.text = "별로예요"
        label.textColor = .black60
        return label
    }()
    
    let badChoiceButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseCategoryView.layer.cornerRadius = 8
    }
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(baseCategoryView)
        self.addSubview(backgroundButton)
        self.addSubview(titleLabel)
        self.addSubview(totalChoiceButtonContainView)
        self.addSubview(goodChoiceContainView)
        self.addSubview(goodChoiceImageView)
        self.addSubview(goodChoiceLabel)
        self.addSubview(goodChoiceButton)
        self.addSubview(badChoiceContainView)
        self.addSubview(badChoiceImageView)
        self.addSubview(badChoiceLabel)
        self.addSubview(badChoiceButton)
    }
    
    override func setupLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(bgView)
            make.bottom.equalTo(baseCategoryView.snp.top)
        }
        
        baseCategoryView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(baseCategoryView.snp.top)
            make.height.equalTo(64)
        }
        
        totalChoiceButtonContainView.snp.makeConstraints { make in
            make.top.equalTo(baseCategoryView.snp.top).offset(70)
            make.width.equalTo(116)
            make.height.equalTo(52)
            make.centerX.equalTo(baseCategoryView)
        }
        
        goodChoiceContainView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(totalChoiceButtonContainView)
            make.width.equalTo(58)
        }
        
        goodChoiceImageView.snp.makeConstraints { make in
            make.top.equalTo(goodChoiceContainView.snp.top)
            make.centerX.equalTo(goodChoiceContainView)
            make.height.width.equalTo(32)
        }
        
        goodChoiceLabel.snp.makeConstraints { make in
            make.top.equalTo(goodChoiceImageView.snp.bottom).offset(4)
            make.bottom.equalTo(goodChoiceContainView.snp.bottom)
            make.horizontalEdges.equalTo(goodChoiceContainView)
        }
        
        goodChoiceButton.snp.makeConstraints { make in
            make.edges.equalTo(goodChoiceContainView)
        }
        
        badChoiceContainView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalTo(totalChoiceButtonContainView)
            make.width.equalTo(58)
        }
        
        badChoiceImageView.snp.makeConstraints { make in
            make.top.equalTo(badChoiceContainView.snp.top)
            make.centerX.equalTo(badChoiceContainView)
            make.height.width.equalTo(32)
        }
        
        badChoiceLabel.snp.makeConstraints { make in
            make.top.equalTo(badChoiceImageView.snp.bottom).offset(4)
            make.bottom.equalTo(badChoiceContainView.snp.bottom)
            make.horizontalEdges.equalTo(badChoiceContainView)
        }
        
        badChoiceButton.snp.makeConstraints { make in
            make.edges.equalTo(badChoiceContainView)
        }
    }
}

extension MovieDetailEvaluateView {
    func updateGoodButtonUI(isSelect: Bool) {
        switch isSelect {
            
        case true:
            self.goodChoiceImageView.image = UIImage(named: "Good_Select")
            self.goodChoiceLabel.textColor = .black5
        case false:
            self.goodChoiceImageView.image = UIImage(named: "Good_Nonselect")
            self.goodChoiceLabel.textColor = .black60
        }
    }
}

extension MovieDetailEvaluateView {
    func updateBadButtonUI(isSelect: Bool) {
        switch isSelect {
            
        case true:
            self.badChoiceImageView.image = UIImage(named: "Bad_Select")
            self.badChoiceLabel.textColor = .black5
        case false:
            self.badChoiceImageView.image = UIImage(named: "Bad_Nonselect")
            self.badChoiceLabel.textColor = .black60
        }
    }
}
