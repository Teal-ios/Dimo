//
//  CharacterMoreView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/23.
//

import UIKit
import SnapKit

final class CharacterMoreView: BaseView {
    let titleLabel: UILabel = {
        let label = UILabel()
        let mbti = UserDefaultManager.mbti ?? "ISFJ"
        label.font = Font.title1
        label.textColor = .black5
        label.numberOfLines = 2
        label.text = "스포주의!\n\(mbti) 캐릭터 모아보기"
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
            make.height.equalTo(74)
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
                    return self.characterLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    private func characterLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 8.5) // Use fractionalHeight instead of fractionalWidth
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item]) // Use vertical instead of horizontal
        
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
