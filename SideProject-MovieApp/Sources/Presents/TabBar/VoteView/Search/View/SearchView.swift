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
    
    let searchContainView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .black90
        return view
    }()
    
    let searchImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Search")
        view.tintColor = .black80
        return view
    }()
    
    let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "작품명 / 캐릭터명을 입력해 주세요"
        return tf
    }()
    
    let categoryInsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "캐릭터명"
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
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(searchContainView)
        self.addSubview(searchImageView)
        self.addSubview(searchTextField)
        self.addSubview(categoryButton)
        self.addSubview(arrowBottomLabel)
        self.addSubview(categoryInsetLabel)
        self.addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        categoryButton.layer.cornerRadius = 8
        categoryButton.layer.borderWidth = 1
        categoryButton.backgroundColor = .black90
        categoryButton.tintColor = Color.caption
        categoryButton.layer.borderColor = UIColor.black80.cgColor
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        searchContainView.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.centerY.equalTo(searchContainView)
            make.leading.equalTo(searchContainView.snp.leading).offset(16)
            make.height.width.equalTo(20)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(8)
            make.centerY.equalTo(searchContainView)
            make.trailing.equalTo(searchContainView.snp.trailing).offset(-16)
            make.verticalEdges.equalTo(searchContainView)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
            make.height.equalTo(32)
            make.width.equalTo(90)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        arrowBottomLabel.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.centerY.equalTo(categoryButton)
            make.trailing.equalTo(categoryButton.snp.trailing).inset(12)
        }
        
        categoryInsetLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryButton.snp.leading).offset(12)
            make.height.equalTo(21)
            make.trailing.equalTo(arrowBottomLabel.snp.leading).inset(4)
            make.centerY.equalTo(categoryButton)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(categoryButton.snp.bottom).offset(16)
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

extension SearchView {
    func configureCategoryUpdate(category: String) {
        if category == SearchCategoryCase.character.rawValue {
            categoryButtonToCharacter()
        } else {
            categoryButtonToWork()
        }
        self.layoutIfNeeded()
    }
}

extension SearchView {
    func categoryButtonToCharacter() {
        categoryButton.snp.removeConstraints()
        categoryButton.snp.remakeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
            make.height.equalTo(32)
            make.width.equalTo(90)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        self.categoryInsetLabel.text = "캐릭터명"
    }
    
    func categoryButtonToWork() {
        categoryButton.snp.removeConstraints()
        categoryButton.snp.remakeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
            make.height.equalTo(32)
            make.width.equalTo(82)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        self.categoryInsetLabel.text = "작품명"
    }
}
