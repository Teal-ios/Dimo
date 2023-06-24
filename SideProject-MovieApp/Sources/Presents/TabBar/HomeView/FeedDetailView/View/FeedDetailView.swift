//
//  FeedDetailView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import SnapKit

final class FeedDetailView: BaseScrollView {
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout())
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private let commentTotalView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let commentContainView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .black90
        return view
    }()
    
    let spoilerButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let spoilerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black60.cgColor
        return view
    }()
    
    let spoilerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textAlignment = .center
        label.textColor = Color.caption
        label.text = "✓ 스포"
        return label
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let registrationView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .black100
        return view
    }()
    
    let registrationLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textAlignment = .center
        label.text = "등록"
        label.textColor = .black80
        return label
    }()
    
    let commentTextField: UITextField = {
        let tf = UITextField()
        tf.font = Font.body2
        tf.textColor = Color.caption
        tf.placeholder = "댓글을 남겨 보세요"
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setHierarchy() {

        self.addSubview(categoryCollectionView)
        self.addSubview(collectionView)
        self.addSubview(commentTotalView)
        self.addSubview(commentContainView)
        self.addSubview(spoilerView)
        self.addSubview(spoilerLabel)
        self.addSubview(spoilerButton)
        self.addSubview(registrationView)
        self.addSubview(registrationLabel)
        self.addSubview(registrationButton)
        self.addSubview(commentTextField)
    }
    
    override func setupLayout() {
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
        }
        
        commentTotalView.snp.makeConstraints { make in
            make.height.equalTo(84)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        commentContainView.snp.makeConstraints { make in
            make.edges.equalTo(commentTotalView).inset(16)
        }
        
        spoilerView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(commentContainView).inset(8)
            make.width.equalTo(52)
        }
        
        spoilerLabel.snp.makeConstraints { make in
            make.edges.equalTo(spoilerView).inset(4)
        }
        
        spoilerButton.snp.makeConstraints { make in
            make.edges.equalTo(spoilerView)
        }
        
        registrationView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalTo(commentContainView).inset(8)
            make.width.equalTo(52)
        }
        
        registrationLabel.snp.makeConstraints { make in
            make.edges.equalTo(registrationView).inset(4)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.edges.equalTo(registrationButton)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(spoilerView.snp.trailing).offset(8)
            make.trailing.equalTo(registrationView.snp.leading).offset(8)
            make.verticalEdges.equalTo(commentContainView)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    private let headerRatio = 1.0
    private let headerAbsolute = 500.0
    
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
    
    private func categoryLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.dynamicCategoryLayout()
                },
            configuration: configuration)
        return collectionViewLayout

    }
}

extension FeedDetailView {
    private func reviewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
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
            elementKind: FeedDetailHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
}

extension FeedDetailView {
    private func dynamicCategoryLayout() -> NSCollectionLayoutSection {
            //item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(200),
                heightDimension: .absolute(32)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(32)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.interItemSpacing = .fixed(8)
            //sections
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
            
            return section
        }
}
