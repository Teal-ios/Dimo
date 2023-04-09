//
//  SignupTermsView.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import UIKit
import SnapKit

final class SignupTermsView: BaseView {
    let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "이용 약관에 동의해 주세요"
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    let termsView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    let acceptButton: OnboardingButton = {
        return OnboardingButton(title: "동의하고 계속하기", ofSize: 14)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func setupLayout() {
        [termsLabel, termsView, acceptButton].forEach { self.addSubview($0) }
        let topLeading: CGFloat = 16
        let buttonHeight: CGFloat = 48
        let buttonBetweenTerms = 24
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
        termsView.snp.makeConstraints { make in
            make.top.equalTo(termsLabel.snp.bottom).offset(bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.bottom.equalTo(acceptButton.snp.top).offset(-buttonBetweenTerms)
        }
    }
}
