//
//  KeywordNotificationViewController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/02.
//

import UIKit
import RxSwift
import RxCocoa

final class ProductNotificationViewController: BaseViewController {
    
    enum Section: Int, CaseIterable {
        case searchedKeyword
        case registeredKeyword
    }
    
    struct Keyword: Hashable {
        let id = UUID()
        var keyword: String
        var isSelected: Bool = false
    }
    
    let productNotificationView = ProductNotificationView()
    let viewModel: ProductNotificationViewModel
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Keyword>!
    private var headerLabelText = BehaviorRelay<String>(value: "")
    
    private var searchedKeyword: [String] = ["8월", "8월의 크리스마스", "크리스마스 스위치"]
    private lazy var searchedKeywordList: [Keyword] = searchedKeyword.map { Keyword(keyword: $0) }
    private lazy var registeredKeywordList: [Keyword] = searchedKeyword.map { Keyword(keyword: $0) }
    
    init(viewModel: ProductNotificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = productNotificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.productNotificationView.collectionView.delegate = self
        self.configureDatasource()
        self.applySnapshot()
    }
    
    func configureDatasource() {
        let searchedKeywordCellRegistration = UICollectionView.CellRegistration<AllMbtiCollectionViewCell, Keyword> { cell, indexPath, itemIdentifier in
            cell.configure(text: itemIdentifier.keyword)
            cell.configureLabelTextColor(.black5)
        }

        let registeredKeywordCellRegistration2 = UICollectionView.CellRegistration<RegisteredKeywordCollectionViewCell, Keyword>  { cell, indexPath, itemIdentifier in
            cell.configure(text: itemIdentifier.keyword)
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, Keyword>(collectionView: productNotificationView.collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            switch Section(rawValue: indexPath.section) {
            case .searchedKeyword:
                return collectionView.dequeueConfiguredReusableCell(using: searchedKeywordCellRegistration, for: indexPath, item: itemIdentifier)
            case .registeredKeyword:
                return collectionView.dequeueConfiguredReusableCell(using: registeredKeywordCellRegistration2, for: indexPath, item: itemIdentifier)
            case .none:
                return .init()
            }
        })
        
        let registeredKeywordHeaderView = UICollectionView.SupplementaryRegistration<RegisteredKeywordHeaderView>(elementKind: RegisteredKeywordHeaderView.reuseIdentifier) { supplementaryView, elementKind, indexPath in
        
        }
        
        self.dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: registeredKeywordHeaderView, for: indexPath)
            
            self.headerLabelText
                .withUnretained(self)
                .bind { (vc, text) in
                    header.headerLabel.text = text
                }
                .disposed(by: self.disposeBag)
            
            return header
        })
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Keyword>()
        snapshot.appendSections([.searchedKeyword, .registeredKeyword])
        snapshot.appendItems(searchedKeywordList, toSection: .searchedKeyword)
        snapshot.appendItems(registeredKeywordList, toSection: .registeredKeyword)
        dataSource.apply(snapshot)
    }
    
}

