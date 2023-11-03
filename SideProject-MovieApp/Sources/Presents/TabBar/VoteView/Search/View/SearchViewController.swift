//
//  SearchViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/03.
//

import UIKit
import RxSwift
import RxCocoa

enum SearchCategoryCase: String {
    case character, work
}

enum RecentSearchKeywordCase: Int {
    case search
    case character
}

enum RecentSearchKeywordItem: Hashable{
    case searchItem(RecentSearchItem)
    case characterItem(RecentCharacterItem)
}

final class SearchViewController: BaseViewController {
    let selfView = SearchView()
    
    private var viewModel: SearchViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("HomeViewController: fatal error")
        
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    let characterCellTapped = PublishRelay<Result>()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Result>!
    private var recentDataSource: UICollectionViewDiffableDataSource<RecentSearchKeywordCase, RecentSearchKeywordItem>!
    
    override func loadView() {
        view = selfView
    }
    
    let searchTextEditFinish = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.collectionView.delegate = self
        self.selfView.recentCollectionView.delegate = self
        self.selfView.searchTextField.delegate = self
        setDataSource()
        setRecentCollectionView()
        setRecentDataSource()
        recentSnapshot()
        self.selfView.configureCategoryUpdate(category: SearchCategoryCase.work.rawValue)
        self.selfView.updateCategoryView(categoryAppear: false)
        
    }
    
    override func setupBinding() {
        let input = SearchViewModel.Input(viewDidLoad: Observable.just(()), searchText: self.selfView.searchTextField.rx.text, searchTextEditFinish: self.searchTextEditFinish, searchCategoryButtonTapped: self.selfView.categoryButton.rx.tap, characterCellTapped: self.characterCellTapped)
        
        let output = self.viewModel.transform(input: input)
        
        output.searchText
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, text in
                vc.selfView.updateSearchTextField(text: text)
            }
            .disposed(by: disposeBag)
        
        output.searchCharacterList
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, searchCharacterList in
                var snapshot = NSDiffableDataSourceSnapshot<Int, Result>()
                snapshot.appendSections([0])
                var characterArr: [Result] = []
                for ele in searchCharacterList.result {
                    guard let ele = ele else { return }
                    characterArr.append(ele)
                }
                vc.selfView.updateSearchException(searchListExist: !characterArr.isEmpty)
                snapshot.appendItems(characterArr, toSection: 0)
                vc.dataSource.apply(snapshot)
                vc.selfView.updateCategoryView(categoryAppear: true)
            }
            .disposed(by: disposeBag)
        
        output.searchWorkList
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, searchWorkList in
                var snapshot = NSDiffableDataSourceSnapshot<Int, Result>()
                snapshot.appendSections([0])
                var characterArr: [Result] = []
                for ele in searchWorkList.result {
                    guard let ele = ele else { return }
                    characterArr.append(ele)
                }
                vc.selfView.updateSearchException(searchListExist: !characterArr.isEmpty)
                snapshot.appendItems(characterArr, toSection: 0)
                vc.dataSource.apply(snapshot)
                vc.selfView.updateCategoryView(categoryAppear: true)
            }
            .disposed(by: disposeBag)
        
        output.currentCategory
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, categoryCase in
                vc.selfView.configureCategoryUpdate(category: categoryCase.rawValue)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    func setDataSource() {
        
        let cellSearchCharacterRegistration = UICollectionView.CellRegistration<VoteCollectionViewCell, Result> { cell, indexPath, itemIdentifier in
            cell.configureAttributeWithSearchCharacter(with: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellSearchCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
}

extension SearchViewController {
    
    func setRecentCollectionView() {
        selfView.recentCollectionView.register(VoteCollectionViewCell.self, forCellWithReuseIdentifier: VoteCollectionViewCell.identifier)
        selfView.recentCollectionView.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
    }
    
    func setRecentDataSource() {
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<SearchHeaderView>(elementKind: SearchHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            switch indexPath.section {
            case 0:
                supplementaryView.titleLabel.text = "11"
            case 1:
                supplementaryView.titleLabel.text = "22"
            default:
                break
            }
        }
        
        recentDataSource = UICollectionViewDiffableDataSource(collectionView: selfView.recentCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let section = RecentSearchKeywordCase(rawValue: indexPath.section)
            
            var value: Any
            
            switch itemIdentifier {
                
            case .searchItem(let item):
                value = item
            case .characterItem(let item):
                value = item
            }
            
            switch section {
            case .search:
                guard let cell = self.selfView.recentCollectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as? RecentSearchCollectionViewCell else { return UICollectionViewCell() }
                return cell
                
            case .character:
                guard let cell = self.selfView.recentCollectionView.dequeueReusableCell(withReuseIdentifier: VoteCollectionViewCell.identifier, for: indexPath) as? VoteCollectionViewCell else { return UICollectionViewCell() }
                return cell
            case .none:
                return UICollectionViewCell()
            }
        })
        
        recentDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        })
        
//        recentDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
//            let header = collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
//
//            return header
//        })
    }
    
    func recentSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<RecentSearchKeywordCase, RecentSearchKeywordItem>()
        
        snapshot.appendSections([.search, .character])
        
        let searchArr = [RecentSearchItem(search_id: 0, user_id: "ㄴ", content: "테스트"), RecentSearchItem(search_id: 2, user_id: "ㅇ", content: "테스트용도")]
        
        let characterArr = [ RecentCharacterItem(recent_chr_list_id: 0, user_id: "", character_id: "", character_img: "", character_name: "정대만", title: "슬램덩크"),
                             RecentCharacterItem(recent_chr_list_id: 0, user_id: "", character_id: "", character_img: "", character_name: "탄지로", title: "귀멸의칼날")]
        
        searchArr.map { snapshot.appendItems([.searchItem($0)], toSection: .search)}
        characterArr.map { snapshot.appendItems([.characterItem($0)], toSection: .character)}
        
        recentDataSource.apply(snapshot)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dataFetchingToCharacterCell(indexPath: indexPath)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextEditFinish.accept(())
        return true
    }
}

extension SearchViewController {
    func dataFetchingToCharacterCell(indexPath: IndexPath) {
        let selectedItem = dataSource.snapshot().itemIdentifiers(inSection: 0)[indexPath.row]
        self.characterCellTapped.accept(selectedItem)
    }
}
