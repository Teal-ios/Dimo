//
//  MBTINotificationView.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/02.
//

import UIKit

final class MBTIKeywordNotificationView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    override func setHierarchy() {
        self.addSubview(collectionView)
    }
    
    override func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(168)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let space = 8.0
            let columns = 4
            
            switch MBTIKeywordNotificationViewController.Section(rawValue: sectionIndex) {
            case .allMbti:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(48))
                
                if #available(iOS 16.0, *) {
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
                    group.interItemSpacing = .fixed(space)
                    
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8.0, bottom: 36.0, trailing: 8.0)
            
                    return section
                } else {
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
                    group.interItemSpacing = .fixed(space)
                    
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8.0, bottom: 36.0, trailing: 8.0)
            
                    return section
                }
            case .registeredMbti:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(48))
                if #available(iOS 16.0, *) {
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
                    group.interItemSpacing = .fixed(space)
                    
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: 4.0, leading: 8.0, bottom: 0, trailing: 8.0)
                    
                    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .absolute(32.0))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                             elementKind: RegisteredMBTIHeaderView.reuseIdentifier,
                                                                             alignment: .top)
                    section.boundarySupplementaryItems = [header]
                    return section
                } else {
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
                    group.interItemSpacing = .fixed(space)
                    
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: 4.0, leading: 8.0, bottom: 0, trailing: 8.0)
                    
                    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .absolute(32.0))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                             elementKind: RegisteredMBTIHeaderView.reuseIdentifier,
                                                                             alignment: .top)
                    section.boundarySupplementaryItems = [header]
                    return section
                }
            default:
                return nil
            }
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }
}
