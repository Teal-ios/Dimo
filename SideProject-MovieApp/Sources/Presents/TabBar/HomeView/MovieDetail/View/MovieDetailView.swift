//
//  MovieDetailView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import SnapKit

final class MovieDetailView: BaseScrollView {
    let detailHeaderView : DetailHeaderView = {
        let view = DetailHeaderView(title: "스즈메의 문단속", subTitle: "애니메이션 | 124분")
        return view
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "LikeNonSelect"), for: .normal)
        return button
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "좋아요"
        return label
    }()
    
    lazy var likeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, likeLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    let evaluateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_rating_off_clear"), for: .normal)
        return button
    }()
    
    let evaluateLabel: UILabel = {
        let label = UILabel()
        label.text = "평가하기"
        return label
    }()
    
    lazy var evaluateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [evaluateButton, evaluateLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    let summarytitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.text = "줄거리"
        return label
    }()
    
    let summaryExplainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.text = "전국 제패를 꿈꾸는 북산고 농구부 5인방의 꿈과 열정, 멈추지 않는 도전을 그린 영화"
        return label
    }()
    
    let gradeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.text = "평점 TOP3"
        return label
    }()
    
    let gradeContainView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let mbtiPreferContainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let unfoldButton: WordLabelButton = {
        let button = WordLabelButton(text: "펼치기")
        return button
    }()
    
    lazy var characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    private let headerRatio = 1.0
    private let headerAbsolute = 200.0
    
    override func setHierarchy() {
        self.addSubview(detailHeaderView)
        self.addSubview(likeStackView)
        self.addSubview(evaluateStackView)
        self.addSubview(summarytitleLabel)
        self.addSubview(summaryExplainLabel)
        self.addSubview(characterCollectionView)
        self.addSubview(gradeTitleLabel)
        self.addSubview(gradeContainView)
        self.addSubview(mbtiPreferContainView)
        self.addSubview(detailLabel)
        self.addSubview(unfoldButton)
    }
    
    override func setupLayout() {
        detailHeaderView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(280)
        }
        
        likeStackView.snp.makeConstraints { make in
            make.top.equalTo(detailHeaderView.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.width.equalTo(48)
            make.height.equalTo(44)
        }
        
        evaluateStackView.snp.makeConstraints { make in
            make.top.equalTo(detailHeaderView.snp.bottom).offset(16)
            make.leading.equalTo(likeStackView.snp.trailing).offset(8)
            make.width.equalTo(48)
            make.height.equalTo(44)
        }
        
        summarytitleLabel.snp.makeConstraints { make in
            make.top.equalTo(likeStackView.snp.bottom).offset(36)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        
        summaryExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(summarytitleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        characterCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(summaryExplainLabel.snp.bottom).offset(16)
            make.height.equalTo(400)
        }
        
        gradeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        
        gradeContainView.snp.makeConstraints { make in
            make.top.equalTo(gradeTitleLabel.snp.bottom).offset(16)
            make.height.equalTo(176)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        mbtiPreferContainView.snp.makeConstraints { make in
            make.top.equalTo(gradeContainView.snp.bottom).offset(16)
            make.height.equalTo(56)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(mbtiPreferContainView.snp.bottom).offset(36)
            make.height.equalTo(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.width.equalTo(60)
        }
        
        unfoldButton.snp.makeConstraints { make in
            make.top.equalTo(mbtiPreferContainView.snp.bottom).offset(36)
            make.height.equalTo(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(60)
        }
    }
}

extension MovieDetailView {
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.characterLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
}

extension MovieDetailView {
    private func characterLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)

        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 4)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MyMomentumHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}
