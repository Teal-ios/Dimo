//
//  KeywordNotificationView.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/02.
//

import UIKit

final class ProductNotificationView: BaseView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white100
        label.font = Font.title1
        label.text = "키워드 알림"
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
    
    let keywordSearchTextField: KeywordSearchTextField = {
        let view = KeywordSearchTextField(placeHolder: "작품명 / 캐릭터명을 입력해 주세요")
        return view
    }()
    
    let categoryContainView: UIView = {
        let view = UIView()
        return view
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
    
    let searchExceptionContainView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    let searchExceptionImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "SearchException")
        view.contentMode = .scaleAspectFill
        view.isHidden = true
        return view
    }()
    
    let searchExceptionExplainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "검색 결과가 없어요\n다른 키워드로 검색해 보세요"
        label.isHidden = true
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    override func setHierarchy() {
        self.addSubview(keywordSearchTextField)
        self.addSubview(categoryContainView)
        self.addSubview(categoryButton)
        self.addSubview(arrowBottomLabel)
        self.addSubview(categoryInsetLabel)
        self.addSubview(collectionView)
        self.addSubview(searchExceptionContainView)
        self.addSubview(searchExceptionImageView)
        self.addSubview(searchExceptionExplainLabel)
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
        keywordSearchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(252)
            make.height.equalTo(52)
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        categoryContainView.snp.makeConstraints { make in
            make.top.equalTo(keywordSearchTextField.snp.bottom).offset(24)
            make.height.equalTo(48)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(categoryContainView.snp.top)
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
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(categoryButton.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        searchExceptionContainView.snp.makeConstraints { make in
            make.edges.equalTo(collectionView)
        }
        
        searchExceptionImageView.snp.makeConstraints { make in
            make.top.equalTo(searchExceptionContainView.snp.top).offset(64)
            make.centerX.equalTo(searchExceptionContainView)
            make.height.equalTo(210)
            make.width.equalTo(224)
        }
        
        searchExceptionExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(searchExceptionImageView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(searchExceptionContainView).inset(16)
            make.height.equalTo(42)
        }
    }
}

//MARK: 최근 검색어 Layout
extension ProductNotificationView {
    
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
            widthDimension: .fractionalWidth(40.0),
            heightDimension: .absolute(40.0)
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
    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            switch ProductNotificationViewController.Section(rawValue: sectionIndex) {
            case .searchedKeyword:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(100),
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
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                return section
            case .registeredKeyword:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(100),
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
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(12.0))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                         elementKind: RegisteredKeywordHeaderView.reuseIdentifier,
                                                                         alignment: .top)
                section.boundarySupplementaryItems = [header]
                return section
            default:
                return nil
            }
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: configuration)
        return layout
    }
}

//MARK: Character Layout
extension ProductNotificationView {
    private func characterLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(66)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

extension ProductNotificationView {
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

extension ProductNotificationView {
    func updateSearchException(searchListExist: Bool) {
        self.searchExceptionContainView.isHidden = searchListExist
        self.searchExceptionImageView.isHidden = searchListExist
        self.searchExceptionExplainLabel.isHidden = searchListExist
    }
}
