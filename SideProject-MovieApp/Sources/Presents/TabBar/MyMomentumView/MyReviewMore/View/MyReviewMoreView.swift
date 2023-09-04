//
//  MyReviewMoreView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import UIKit
import SnapKit

final class MyReviewMoreView: BaseView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.textColor = .black5
        label.text = "내가 쓴 리뷰"
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
            make.height.equalTo(45)
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
    
    private func reviewLayout() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(itemRatio),
                heightDimension: .fractionalHeight(itemRatio)

            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(groupRatio),
                heightDimension: .absolute(160)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
    }
}
