//
//  FeedView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import SnapKit

final class FeedView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    let writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "write"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupLayout() {
        self.addSubview(collectionView)
        self.addSubview(writeButton)
        collectionView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(334)
        }
        
        writeButton.snp.makeConstraints { make in
            make.height.width.equalTo(51)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.feedLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
        
    private func feedLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 1.5) // Use fractionalHeight instead of fractionalWidth
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item]) // Use vertical instead of horizontal
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}
