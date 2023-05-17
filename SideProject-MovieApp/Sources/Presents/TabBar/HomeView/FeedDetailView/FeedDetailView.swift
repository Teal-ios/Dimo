//
//  FeedDetailView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import SnapKit

class FeedDetailView: BaseScrollView {
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout())
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupLayout() {
        self.addSubview(categoryCollectionView)
        self.addSubview(collectionView)
        
        categoryCollectionView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    private let headerRatio = 1.0
    private let headerAbsolute = 500.0
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.reviewLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    private func categoryLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.dynamicCategoryLayout()
                },
            configuration: configuration)
        return collectionViewLayout

    }
}

extension FeedDetailView {
    private func reviewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: FeedDetailHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
}

extension FeedDetailView {
    private func dynamicCategoryLayout() -> NSCollectionLayoutSection {
            //item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(200),
                heightDimension: .absolute(32)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(32)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.interItemSpacing = .fixed(8)
            //sections
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
            
            return section
        }
}
