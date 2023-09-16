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
    
    let keywordSearchTextField: KeywordSearchTextFieldView = {
        let view = KeywordSearchTextFieldView(placeHolder: "작품명 / 캐릭터명을 입력해 주세요")
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 16.0
        return stackView
    }()

    let categoryButton: CategoryButton = {
        let button = CategoryButton(title: "작품명")
        button.isHidden = true
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout(sectionBottomInset: 8.0))
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    override func setHierarchy() {
        containerStackView.addArrangedSubview(categoryButton)
        containerStackView.addArrangedSubview(collectionView)
        
        self.addSubview(keywordSearchTextField)
        self.addSubview(containerStackView)
    }
    
    override func setupLayout() {
        keywordSearchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(252)
            make.height.equalTo(52)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(keywordSearchTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(82)
            make.height.equalTo(32)
        }

        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(categoryButton.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

//MARK: 최근 검색어 Layout
extension ProductNotificationView {
  
    func createLayout(sectionBottomInset: CGFloat) -> UICollectionViewLayout {
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
                section.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 16.0, bottom: sectionBottomInset, trailing: 16.0)
                
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
                section.contentInsets = NSDirectionalEdgeInsets(top: 4.0, leading: 16.0, bottom: 0, trailing: 16.0)
                
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(32.0))
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

extension ProductNotificationView {
    
    func hideCategoryButton(_ isHidden: Bool) {
        categoryButton.isHidden = isHidden
    }

}
