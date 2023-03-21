//
//  IamTheMainCharacterView.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/21.
//

import UIKit
import SnapKit

class IamTheMainCharacterView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func setupData() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemRatio = 1.0
        let groupRatio = 0.9
        let headerRatio = 1.0
        let headerAbsolute = 40.0
        
        return UICollectionViewCompositionalLayout { section, env in
            switch section {
            case 0:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemRatio),
                    heightDimension: .fractionalHeight(itemRatio)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
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
                    elementKind: IamTheMainCharacterHeader.identifier, alignment: .top
                )
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.boundarySupplementaryItems = [header]
                section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
                return section
            default:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemRatio / 2),
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
                    elementKind: IamTheMainCharacterHeader.identifier, alignment: .top
                )
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.boundarySupplementaryItems = [header]
                section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
                return section
            }
        }
    }
    
}
