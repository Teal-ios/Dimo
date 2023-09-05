//
//  MyContentMoreView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/27.
//

import UIKit
import SnapKit

final class MyContentMoreView: BaseView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.text = "내가 찜한 콘텐츠"
        return label
    }()
    
    let categoryInsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "애니"
        return label
    }()
    
    let arrowBottomLabel: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow_bottom")
        return view
    }()
    
    let categoryButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryButton.layer.cornerRadius = 8
        categoryButton.layer.borderWidth = 1
        categoryButton.backgroundColor = .black90
        categoryButton.tintColor = Color.caption
        categoryButton.layer.borderColor = UIColor.black80.cgColor
    }
    
    override func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(categoryButton)
        self.addSubview(categoryInsetLabel)
        self.addSubview(arrowBottomLabel)
        self.addSubview(cardCollectionView)
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(-8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(32)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.height.equalTo(32)
            make.width.equalTo(69)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        categoryInsetLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryButton.snp.leading).offset(12)
            make.width.equalTo(25)
            make.height.equalTo(21)
            make.centerY.equalTo(categoryButton)
        }
        
        arrowBottomLabel.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.centerY.equalTo(categoryButton)
            make.leading.equalTo(categoryInsetLabel.snp.trailing).offset(4)
        }
        
        cardCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryButton.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
}

extension MyContentMoreView {
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
    
    private func cardLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalWidth(groupRatio / 2)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        
//        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}
