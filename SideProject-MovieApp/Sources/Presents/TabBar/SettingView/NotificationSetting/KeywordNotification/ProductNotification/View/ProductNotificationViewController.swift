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
    private var registeredKeywordCellSelected = PublishRelay<Keyword>()
    private var isSearchedKeyword = PublishRelay<Bool>()
    private var isEmptyRegisteredKeywordList = PublishRelay<Bool>()
    
    private var searchedKeyword: [String] = ["8월", "8월의 크리스마스", "크리스마스 스위치", "크리스마스의 악목", "배드 맘스 크리스마스"]
    private var registeredKeyword: [String] = ["더글로리", "헤어질 결심", "슬램덩크"]
    
    private lazy var searchedKeywordList: [Keyword] = []
    private lazy var registeredKeywordList: [Keyword] = registeredKeyword.map { Keyword(keyword: $0) }
    
    init(viewModel: ProductNotificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = productNotificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productNotificationView.collectionView.delegate = self
        self.configureDatasource()
        self.applySnapshot()
        self.bind()
        
        if registeredKeywordList.isEmpty {
            isEmptyRegisteredKeywordList.accept(true)
        } else {
            isEmptyRegisteredKeywordList.accept(false)
        }
    }
    
    override func setupBinding() {
        let input = ProductNotificationViewModel.Input(didTappedSearchButton: productNotificationView.keywordSearchTextField.searchTextField.rx.controlEvent(.editingDidEndOnExit)
        )
        
        let output = viewModel.transform(input: input)
        
        output.isTappedSearchButton
            .withUnretained(self)
            .bind { (vc, isTapped) in
                vc.productNotificationView.hideCategoryButton(!isTapped)
                if isTapped {
                    vc.productNotificationView.collectionView.setCollectionViewLayout(vc.productNotificationView.createLayout(sectionBottomInset: 48.0), animated: true)
                    vc.searchedKeywordList = vc.searchedKeyword.map { Keyword(keyword: $0) }
                    vc.isSearchedKeyword.accept(true)
                    vc.applySnapshot()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func bind() {
        registeredKeywordCellSelected
            .withUnretained(self)
            .bind(onNext: { (vc, item) in
                guard let index = vc.searchedKeywordList.map({ $0.keyword }).firstIndex(of: item.keyword) else { return }
                vc.searchedKeywordList[index].isSelected = item.isSelected
            })
            .disposed(by: disposeBag)
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
            
            if self.registeredKeywordList.isEmpty {
                header.isHidden = true
            } else {
                header.isHidden = false
            }
            
            self.isSearchedKeyword
                .withUnretained(self)
                .bind { (vc, isSearched) in
                    header.borderView.isHidden = !isSearched
                }
                .disposed(by: self.disposeBag)
            
            self.isEmptyRegisteredKeywordList
                .withUnretained(self)
                .bind { (vc, isEmpty) in
                    header.isHidden = isEmpty
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

extension ProductNotificationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .searchedKeyword:
            let cellIsSelected = searchedKeywordList[indexPath.item].isSelected
            guard !cellIsSelected else { return }
            
            let selectedKeyword = searchedKeywordList[indexPath.item].keyword
            let isRegisteredKeyword = registeredKeywordList.contains { Keyword in
                return Keyword.keyword == selectedKeyword
            }
  
            guard !isRegisteredKeyword && registeredKeywordList.count < 5 else { return }
            registeredKeywordList.append(Keyword(keyword: selectedKeyword))
            searchedKeywordList[indexPath.item].isSelected = true
            isEmptyRegisteredKeywordList.accept(false)
            applySnapshot()
        case .registeredKeyword:
            fetchRegisteredKeywordCellData(indexPath: indexPath)
            registeredKeywordList.remove(at: indexPath.item)
            if registeredKeywordList.isEmpty {
                isEmptyRegisteredKeywordList.accept(true)
            }
            applySnapshot()
        default:
            break
        }
    }
}

extension ProductNotificationViewController {
    func fetchRegisteredKeywordCellData(indexPath: IndexPath) {
        let selectedKeyword = dataSource.snapshot().itemIdentifiers(inSection: Section.registeredKeyword)[indexPath.item]
        self.registeredKeywordCellSelected.accept(Keyword(keyword: selectedKeyword.keyword, isSelected: selectedKeyword.isSelected))
    }
}

