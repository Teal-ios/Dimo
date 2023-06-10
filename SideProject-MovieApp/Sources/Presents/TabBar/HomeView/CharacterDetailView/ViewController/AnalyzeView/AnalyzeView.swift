//
//  AnalyzeView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/09.
//

import UIKit
import SnapKit

final class AnalyzeView: BaseView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .white100
        label.text = "DIMO 유저들의 생각"
        return label
    }()
    
    let chartContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let reviewContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let choiceContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let rowVoteContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let voteButton: OnboardingButton = {
        let button = OnboardingButton(title: "투표하기")
        return button
    }()
    
    let revoteButton: WordLabelButton = {
        let button = WordLabelButton(text: "다시 투표하기")
        return button
    }()
    
    lazy var totalStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
}
