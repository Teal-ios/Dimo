//
//  ErrorCommonView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/04.
//

import UIKit
import SnapKit

final class ErrorCommonView: BaseView {
    let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.title3
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "일시적인 오류가 발생했어요 \n 잠시 후 다시 시도해주세요"
        return label
    }()
    
    let imageLayoutView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let errorWarningImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ErrorWarning")
        return view
    }()
    
    let errorCharacterImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ErrorCharacter")
        return view
    }()

    let retryButton: OnboardingButton = {
        let button = OnboardingButton(title: "다시 시도하기", ofSize: 14)
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(retryButton)
        self.addSubview(explainLabel)
        self.addSubview(imageLayoutView)
        self.addSubview(errorWarningImageView)
        self.addSubview(errorCharacterImageView)

    }
    
    override func setupLayout() {
        
        retryButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(36)
            make.height.equalTo(48)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.bottom.equalTo(retryButton.snp.top).offset(-120)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        imageLayoutView.snp.makeConstraints { make in
            make.bottom.equalTo(explainLabel.snp.top).offset(-24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(55)
            make.height.equalTo(imageLayoutView.snp.width)
        }
        
        
        errorWarningImageView.snp.makeConstraints { make in
            make.top.trailing.equalTo(imageLayoutView).inset(34)
            make.height.width.equalTo(138)
        }
        
        errorCharacterImageView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(imageLayoutView).inset(34)
            make.width.equalTo(140)
            make.height.equalTo(148)
        }
    }
}
