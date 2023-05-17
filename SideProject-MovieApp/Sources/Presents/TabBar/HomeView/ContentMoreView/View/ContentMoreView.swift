//
//  ContentMoreView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import SnapKit

final class ContentMoreView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.textColor = .white100
        label.text = "ISFJ가 주인공인 영화"
        return label
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupLayout() {
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        titleLabel.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(28)
        }
        collectionView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    private let headerRatio = 1.0
    private let posterHeightRatio = 0.67
    private let headerAbsolute = 40.0
    private let todayDIMOHeaderAbsolute = 108.0
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.cardLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
}

extension ContentMoreView {
    private func cardLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
