//
//  ErrorNotFoundView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/04.
//

import UIKit
import SnapKit

final class ErrorNotFoundView: BaseView {
    let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.title3
        label.textAlignment = .center
        label.text = "페이지를 찾을 수 없어요"
        return label
    }()
    
    let errorNotFoundPageImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "NotFoundPage")
        return view
    }()

    
    let retryButton: OnboardingButton = {
        let button = OnboardingButton(title: "다시 시도하기", ofSize: 14)
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(retryButton)
        self.addSubview(errorNotFoundPageImageView)
        self.addSubview(explainLabel)

    }
    
    override func setupLayout() {
        errorNotFoundPageImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(55)
            make.height.equalTo(errorNotFoundPageImageView.snp.width)
        }
        
        retryButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(36)
            make.height.equalTo(48)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(errorNotFoundPageImageView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(72)
            make.height.equalTo(38)
        }
    }
}
