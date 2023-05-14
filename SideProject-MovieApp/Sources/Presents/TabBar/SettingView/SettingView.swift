//
//  SettingView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import SnapKit

final class SettingView: BaseView {
    let titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .white100
        label.text = "설정"
        label.font = Font.title1
        return label
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupLayout() {
        self.addSubview(titleLable)
        self.addSubview(collectionView)
        
        titleLable.snp.makeConstraints { make in
            make.height.width.equalTo(28)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(titleLable.snp.bottom).offset(44)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    private let headerRatio = 1.0
    private let headerAbsolute = 60.0
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.settingLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
        
    private func settingLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 13) // Use fractionalHeight instead of fractionalWidth
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item]) // Use vertical instead of horizontal
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: SettingHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
}
