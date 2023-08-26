//
//  CharacterAskView.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/21.
//

import UIKit

final class CharacterAskView: BaseView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.text = "캐릭터 요청하기"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.numberOfLines = 0
        label.text = "찾고 있는 캐릭터가 없으신가요? DIMO에서 다뤘으면 하는 캐릭터를 추천해주세요. 검토 후 적극적으로 반영해 보도록 하겠습니다!"
        return label
    }()
    
    let categorySectionLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.text = "카테고리"
        return label
    }()
    
    // MARK: - 업데이트 예정
    let movieView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "영화")
        view.isHidden = true
        return view
    }()
    
    let animationView: DrawButtonLabel = {
        let view = DrawButtonLabel(text: "애니")
        return view
    }()
    
    let detailInfoSectionLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.text = "상세정보"
        return label
    }()
    
    let productTitleView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "작품명")
    }()
    
    let characterNameView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "캐릭터명")
    }()
    
    let askButton: OnboardingButton = {
        let button = OnboardingButton(title: "요청하기")
        button.isEnabled = false
        button.configuration?.baseForegroundColor = .white
        button.configuration?.baseBackgroundColor = .black80
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(headerLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(categorySectionLabel)
        self.addSubview(movieView)
        self.addSubview(animationView)
        self.addSubview(detailInfoSectionLabel)
        self.addSubview(productTitleView)
        self.addSubview(characterNameView)
        self.addSubview(askButton)
    }
    
    override func setupLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(16)
            make.height.equalTo(28)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.leading)
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        categorySectionLabel.snp.makeConstraints { make in
            make.leading.equalTo(subtitleLabel.snp.leading)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
        }
        
        movieView.snp.makeConstraints { make in
            make.leading.equalTo(categorySectionLabel.snp.leading)
            make.top.equalTo(categorySectionLabel.snp.bottom).offset(8)
            make.height.equalTo(52)
        }
        
        animationView.snp.makeConstraints { make in
            make.leading.equalTo(categorySectionLabel.snp.leading)
            make.top.equalTo(categorySectionLabel.snp.bottom).offset(8)
            make.height.equalTo(52)
        }
        
        detailInfoSectionLabel.snp.makeConstraints { make in
            make.leading.equalTo(categorySectionLabel.snp.leading)
            make.top.equalTo(animationView.snp.bottom).offset(24)
        }
        
        productTitleView.snp.makeConstraints { make in
            make.leading.equalTo(detailInfoSectionLabel.snp.leading)
            make.top.equalTo(detailInfoSectionLabel.snp.bottom).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        characterNameView.snp.makeConstraints { make in
            make.leading.equalTo(productTitleView.snp.leading)
            make.top.equalTo(productTitleView.snp.bottom).offset(24)
            make.trailing.equalTo(productTitleView.snp.trailing)
        }
        
        askButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(36)
            make.height.equalTo(48)
        }
    }
}

extension CharacterAskView {
    
    func updateMovieViewButtonState(_ isTapped: Bool) {
        movieView.checkButton.isSelected = isTapped
        
    }
    
    func updateAnimationViewButtonState(_ isTapped: Bool) {
        animationView.checkButton.isSelected = isTapped
    }
    
    func updateAskButtonState(_ isRequestable: Bool) {
        if isRequestable {
            askButton.isEnabled = true
            askButton.configuration?.baseBackgroundColor = .purple100
            askButton.configuration?.baseForegroundColor = .white100
        } else {
            askButton.isEnabled = false
            askButton.configuration?.baseBackgroundColor = .black80
            askButton.configuration?.baseForegroundColor = .white100
        }
    }
}
