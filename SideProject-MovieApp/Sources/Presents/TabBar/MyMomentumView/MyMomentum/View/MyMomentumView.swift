//
//  MyMomentumView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import SnapKit

class MyMomentumView: BaseView {
    
    lazy var containScrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(profileCollectionView)
        view.addSubview(digFinishCharacherCollectionView)
        view.addSubview(reviewCollectionView)
        view.addSubview(commentCollectionView)
        return view
    }()
    
    lazy var profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createProfileLayout())
    lazy var digFinishCharacherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createDigFinishLayout())
    lazy var reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createReviewCommentLayout())
    lazy var commentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createReviewCommentLayout())
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setHierarchy() {
        self.addSubview(containScrollView)
    }
    
    override func setupAttributes() {
        self.profileCollectionView.isScrollEnabled = false
        self.digFinishCharacherCollectionView.isScrollEnabled = false
        self.reviewCollectionView.isScrollEnabled = false
        self.commentCollectionView.isScrollEnabled = false
    }
    
    override func setupLayout() {
        containScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        profileCollectionView.snp.makeConstraints { make in
            make.top.equalTo(containScrollView.snp.top)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(600)
        }
        
        digFinishCharacherCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        
        reviewCollectionView.snp.makeConstraints { make in
            make.top.equalTo(digFinishCharacherCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        
        commentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(reviewCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 0.93
    private let headerRatio = 1.0
    private let headerAbsolute = 40.0
    private let profileHeaderAbsolute = 410.0
    
    private func createProfileLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            default: return self.profileLayout()
            }
        }, configuration: configuration)
        return collectionViewLayout
    }
    
    private func createDigFinishLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            default: return self.characterLayout()
            }
        }, configuration: configuration)
        return collectionViewLayout
    }
    
    private func createReviewCommentLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            default: return self.reviewLayout()
            }
        }, configuration: configuration)
        return collectionViewLayout
    }
    
    private func profileLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(profileHeaderAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: ProfileHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}

extension MyMomentumView {
    private func characterLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)

        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MyMomentumHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}

extension MyMomentumView {
    private func reviewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)

        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MyMomentumHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}
