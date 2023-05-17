//
//  MovieDetailView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import SnapKit

final class MoviewDetailView: BaseScrollView {
    let detailHeaderView : DetailHeaderView = {
        let view = DetailHeaderView(title: "스즈메의 문단속", subTitle: "애니메이션 | 124분")
        return view
    }()
    
    let likeStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    let evaluateStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    let likeImgView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let evaluateImgView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let evaluateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let summarytitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let summaryExplainLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let gradeTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    lazy var characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    private let headerRatio = 1.0
    private let headerAbsolute = 40.0
}

extension MoviewDetailView {
    
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

extension MoviewDetailView {
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
