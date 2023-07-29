//
//  HomeView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    lazy var containScrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(posterStackView)
        view.addSubview(mbtiHeroStackView)
        view.addSubview(characterStackView)
        view.addSubview(recommendStackView)
        view.addSubview(nowHotStackView)
        return view
    }()
    
    lazy var posterStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(posterCollectionView)
        return view
    }()
    
    lazy var mbtiHeroStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(mbtiHeroCharacterCollectionView)
        return view
    }()
    
    lazy var characterStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(characterCollectionView)
        return view
    }()
    
    lazy var recommendStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(recommendCollectionView)
        return view
    }()
    
    lazy var nowHotStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(nowHotCollectionView)
        return view
    }()
    
    lazy var posterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: posterCreateLayout())
    
    lazy var mbtiHeroCharacterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: mbtiHeroCharacterCreateLayout())
    
    lazy var characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: mbtiHeroCharacterCreateLayout())
    
    lazy var recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recommendCreateLayout())
    
    lazy var nowHotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: nowHotCreateLayout())
    
    let categoryButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let mbtiHeroMoreButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let characterMoreButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let recommendMoreButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let nowHotMoreButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setHierarchy() {
        self.addSubview(containScrollView)
        self.addSubview(categoryButton)
        self.addSubview(mbtiHeroMoreButton)
        self.addSubview(characterMoreButton)
        self.addSubview(recommendMoreButton)
        self.addSubview(nowHotMoreButton)
    }
    
    override func setupAttributes() {
        self.posterCollectionView.isScrollEnabled = false
        self.characterCollectionView.isScrollEnabled = false
        self.recommendCollectionView.isScrollEnabled = false
        self.nowHotCollectionView.isScrollEnabled = false
        self.mbtiHeroCharacterCollectionView.isScrollEnabled = false
    }
    
    override func setupLayout() {
        
        containScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        posterStackView.snp.makeConstraints { make in
            make.top.equalTo(containScrollView.snp.top)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(604)
        }
        
        mbtiHeroStackView.snp.makeConstraints { make in
            make.top.equalTo(posterStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(260)
        }
        
        characterStackView.snp.makeConstraints { make in
            make.top.equalTo(mbtiHeroStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(216)
        }
        
        recommendStackView.snp.makeConstraints { make in
            make.top.equalTo(characterStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(260)
        }
        
        nowHotStackView.snp.makeConstraints { make in
            make.top.equalTo(recommendStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(260)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.leading.equalTo(posterStackView.safeAreaLayoutGuide).offset(16)
            make.top.equalTo(posterStackView.snp.top).offset(56)
            make.height.equalTo(44)
            make.width.equalTo(80)
        }
        
        mbtiHeroMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(mbtiHeroStackView).offset(-16)
            make.top.equalTo(mbtiHeroStackView)
            make.height.equalTo(40)
            make.width.equalTo(58)
        }
        
        characterMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(characterStackView).offset(-16)
            make.top.equalTo(characterStackView)
            make.height.equalTo(40)
            make.width.equalTo(58)
        }
        
        recommendMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(recommendStackView).offset(-16)
            make.top.equalTo(recommendStackView)
            make.height.equalTo(40)
            make.width.equalTo(58)
        }
        
        nowHotMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(nowHotStackView).offset(-16)
            make.top.equalTo(nowHotStackView)
            make.height.equalTo(40)
            make.width.equalTo(58)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 0.92
    private let headerRatio = 1.0
    private let posterHeightRatio = 0.8
    private let headerAbsolute = 40.0
    private let todayDIMOHeaderAbsolute = 108.0
}

extension HomeView {
    private func cardLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio / 1.2)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 8)
        
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

extension HomeView {
    private func characterLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio / 1.2)

        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 8)
        
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

extension HomeView {
    private func posterLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)

        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(posterHeightRatio)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(todayDIMOHeaderAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: TodayDIMOHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}

extension HomeView {
    private func posterCreateLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.posterLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    private func mbtiHeroCharacterCreateLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.cardLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    private func characterCreateLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.characterLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    private func recommendCreateLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.cardLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    private func nowHotCreateLayout() -> UICollectionViewLayout {
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
