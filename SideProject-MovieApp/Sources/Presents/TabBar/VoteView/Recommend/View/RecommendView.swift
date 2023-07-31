//
//  RecommendView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/09.
//

import UIKit
import SnapKit

final class RecommendView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white100
        label.font = Font.title1
        label.text = "캐릭터 랜덤 추천"
        return label
    }()
    
    let categoryInsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "랜덤순"
        return label
    }()
    
    let arrowBottomLabel: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow_bottom")
        return view
    }()
    
    let categoryButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.backgroundColor = .black90
        button.tintColor = Color.caption
        button.layer.borderColor = UIColor.black80.cgColor
        return button
    }()

    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(categoryButton)
        self.addSubview(categoryInsetLabel)
        self.addSubview(arrowBottomLabel)
        self.addSubview(collectionView)
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(32)
            make.width.equalTo(82)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        categoryInsetLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryButton.snp.leading).offset(12)
            make.width.equalTo(38)
            make.height.equalTo(21)
            make.centerY.equalTo(categoryButton)
        }
        
        arrowBottomLabel.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.centerY.equalTo(categoryButton)
            make.leading.equalTo(categoryInsetLabel.snp.trailing).offset(4)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(categoryButton.snp.bottom).offset(32)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
}

//MARK: 최근 검색어 Layout
extension RecommendView {
    
    private func collectionViewLayout() -> UICollectionViewLayout {
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

//MARK: Character Layout
extension RecommendView {
    private func characterLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 9)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
