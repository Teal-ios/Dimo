//
//  SearchView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/03.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white100
        label.font = Font.title1
        label.text = "캐릭터 찾아보기"
        return label
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 4
        searchBar.placeholder = "작품명 / 캐릭터명을 입력해 주세요."
        
        return searchBar
    }()
    
//    let searchBarContainView: SearchBarContainerView = {
//        let searchBar = UISearchBar()
//        searchBar.clipsToBounds = true
//        searchBar.layer.cornerRadius = 4
//        searchBar.placeholder = "작품명 / 캐릭터명을 입력해 주세요."
//        let view = SearchBarContainerView(customSearchBar: searchBar)
//        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 52)
//        return view
//    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(searchBar)
        self.addSubview(collectionView)
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(84)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    private let headerRatio = 1.0
    private let headerAbsolute = 40.0
}

//MARK: 최근 검색어 Layout
extension SearchView {
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    switch sectionIndex {
                    case 0: return self.dynamicCategoryLayout()
                    case 1: return self.characterLayout()
                    default: return self.dynamicCategoryLayout()
                    }
                },
            configuration: configuration)
        return collectionViewLayout
        
    }
    
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
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: SearchHeaderView.identifier, alignment: .topLeading
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 36, trailing: 0)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

//MARK: Character Layout
extension SearchView {
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
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: SearchHeaderView.identifier, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
