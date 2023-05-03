//
//  MyMomentumView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import SnapKit

class MyMomentumView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupLayout() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 0.9
    private let headerRatio = 1.0
    private let headerAbsolute = 40.0
    private let profileHeaderAbsolute = 500.0
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    switch sectionIndex {
                    case 0: return self.profileLayout()
                    default: return self.characterLayout()
                    }
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    private func profileLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(profileHeaderAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: ProfileHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}

extension MyMomentumView {
    private func characterLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)

        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
        
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
            elementKind: MyMomentumHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}
//
//extension MyMomentumView {
//    private func characterLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(itemRatio / 2),
//            heightDimension: .fractionalHeight(itemRatio / 1.2)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
//
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(groupRatio),
//            heightDimension: .fractionalHeight(groupRatio / 3)
//        )
//
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        let headerSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(headerRatio),
//            heightDimension: .absolute(headerAbsolute)
//        )
//        let header = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: CharacterRecommandAndSearchHeaderView.identifier, alignment: .top
//        )
//
//        let section = NSCollectionLayoutSection(group: group)
//
//        section.boundarySupplementaryItems = [header]
//        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
//        return section
//    }
//}
//
//extension MyMomentumView {
//    private func reviewAndCommentLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(itemRatio / 2),
//            heightDimension: .fractionalHeight(itemRatio / 1.2)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
//
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(groupRatio),
//            heightDimension: .fractionalHeight(groupRatio / 3)
//        )
//
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        let headerSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(headerRatio),
//            heightDimension: .absolute(headerAbsolute)
//        )
//        let header = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: CharacterRecommandAndSearchHeaderView.identifier, alignment: .top
//        )
//
//        let section = NSCollectionLayoutSection(group: group)
//
//        section.boundarySupplementaryItems = [header]
//        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
//        return section
//    }
//}
