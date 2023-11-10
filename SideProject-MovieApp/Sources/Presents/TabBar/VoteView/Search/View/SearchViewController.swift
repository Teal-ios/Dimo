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

enum RecentSearchKeywordItem: Hashable {
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
    let recentCellTapped = PublishRelay<RecentSearchKeywordItem>()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Result>!
    private var recentDataSource: UICollectionViewDiffableDataSource<RecentSearchKeywordCase, RecentSearchKeywordItem>!
    
    override func loadView() {
        view = selfView
    }
    
    let searchTextEditFinish = PublishRelay<Void>()
    let recentCharacterCancelButtonTapped = PublishRelay<RecentSearchKeywordItem>()
    let recentSearchCancelButtonTapped = PublishRelay<RecentSearchKeywordItem>()
    let updateSearchTextFieldTrigger = PublishRelay<String>()
    let recentSearchAllDeleteButtonTapped = PublishRelay<Void>()
    let recentCharacterAllDeleteButtonTapped = PublishRelay<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.collectionView.delegate = self
        self.selfView.recentCollectionView.delegate = self
        self.selfView.searchTextField.delegate = self
        setDataSource()
        setRecentCollectionView()
        setRecentDataSource()
        self.selfView.configureCategoryUpdate(category: SearchCategoryCase.work.rawValue)
        self.selfView.updateCategoryView(categoryAppear: false)
        
    }
    
    override func setupBinding() {
        let input = SearchViewModel
            .Input(
                viewDidLoad: Observable.just(()),
                searchText: self.selfView.searchTextField.rx.text,
                searchTextEditFinish: self.searchTextEditFinish,
                searchCategoryButtonTapped:
                    self.selfView.categoryButton.rx.tap,
                characterCellTapped: self.characterCellTapped,
                recentCellTapped: self.recentCellTapped,
                recentCharacterCancelButtonTapped: self.recentCharacterCancelButtonTapped,
                recentSearchCancelButtonTapped: self.recentSearchCancelButtonTapped,
                updateSearchTextFieldTrigger: self.updateSearchTextFieldTrigger,
                recentSearchAllDeleteButtonTapped: self.recentSearchAllDeleteButtonTapped,
                recentCharacterAllDeleteButtonTapped: self.recentCharacterAllDeleteButtonTapped
        )
        
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
        
        output.updateSearchTextTrigger
            .withUnretained(self)
            .bind { owner, text in
                owner.selfView.searchTextField.text = text
                owner.updateSearchTextFieldTrigger.accept(text)
            }
            .disposed(by: disposeBag)
        
        output.recentDataIsEmptyTrigger
            .withUnretained(self)
            .bind { owner, _ in
                owner.selfView.recentCollectionView.isHidden = true
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.recentSearchList, output.recentCharacterList)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] searchList, characterList in
                guard let self = self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<RecentSearchKeywordCase, RecentSearchKeywordItem>()
                
                snapshot.appendSections([.search, .character])
                
                var searchArr: [RecentSearchItem] = []
                var characterArr: [RecentCharacterItem] = []
                
                if searchList != nil {
                    guard let searchList = searchList else { return }
                    for ele in searchList {
                        guard let ele = ele else { return }
                        searchArr.append(ele)
                    }
                }
                
                if characterList != nil {
                    guard let characterList = characterList else { return }
                    for ele in characterList {
                        guard let ele = ele else { return }
                        characterArr.append(ele)
                    }
                }
                
                searchArr.map { snapshot.appendItems([.searchItem($0)], toSection: .search)}
                characterArr.map { snapshot.appendItems([.characterItem($0)], toSection: .character)}
                
                recentDataSource.apply(snapshot)
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
        
        selfView.recentCollectionView.delegate = self
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<SearchHeaderView>(elementKind: SearchHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            switch indexPath.section {
            case 0:
                supplementaryView.titleLabel.text = "최근 검색어"
                supplementaryView.moreButton.rx.tap
                    .withUnretained(self)
                    .bind { owner, _ in
                        owner.recentSearchAllDeleteButtonTapped.accept(())
                        supplementaryView.disposeBag = DisposeBag()
                    }
                    .disposed(by: supplementaryView.disposeBag)
            case 1:
                supplementaryView.titleLabel.text = "최근 본 캐릭터"
                supplementaryView.moreButton.rx.tap
                    .withUnretained(self)
                    .bind { owner, _ in
                        owner.recentCharacterAllDeleteButtonTapped.accept(())
                        supplementaryView.disposeBag = DisposeBag()
                    }
                    .disposed(by: supplementaryView.disposeBag)
            default:
                break
            }
        }
        
        recentDataSource = UICollectionViewDiffableDataSource(collectionView: selfView.recentCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let section = RecentSearchKeywordCase(rawValue: indexPath.section)
            
            var value: Any
            var searchItem: RecentSearchItem?
            var characterItem: RecentCharacterItem?
            switch itemIdentifier {
                
            case .searchItem(let item):
                value = item
                searchItem = item
            case .characterItem(let item):
                value = item
                characterItem = item
            }
            
            switch section {
            case .search:
                guard let cell = self.selfView.recentCollectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as? RecentSearchCollectionViewCell else { return UICollectionViewCell() }
                cell.configureAttribute(with: searchItem)
                cell.cancelButton
                    .rx.tap
                    .withUnretained(self)
                    .bind { owner, _ in
                        owner.recentSearchCancelButtonTapped.accept(itemIdentifier)
                        print(itemIdentifier, "검색어취소")
                        cell.disposeBag = DisposeBag()
                    }
                    .disposed(by: cell.disposeBag)
                return cell
                
            case .character:
                guard let cell = self.selfView.recentCollectionView.dequeueReusableCell(withReuseIdentifier: VoteCollectionViewCell.identifier, for: indexPath) as? VoteCollectionViewCell else { return UICollectionViewCell() }
                cell.configureAtrributeWithRecentCharacter(with: characterItem)
                cell.cancelButton
                    .rx.tap
                    .withUnretained(self)
                    .bind { owner, _ in
                        owner.recentCharacterCancelButtonTapped.accept(itemIdentifier)
                        print(itemIdentifier, "캐릭터취소")
                        cell.disposeBag = DisposeBag()
                    }
                    .disposed(by: cell.disposeBag)
                return cell
            case .none:
                return UICollectionViewCell()
            }
        })
        
        recentDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        })
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == selfView.recentCollectionView {
            self.dataFetchingToRecentCell(indexPath: indexPath)
        } else if collectionView == selfView.collectionView {
            self.dataFetchingToCharacterCell(indexPath: indexPath)
        }
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

extension SearchViewController {
    func dataFetchingToRecentCell(indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let selectedItem = recentDataSource.snapshot().itemIdentifiers(inSection: .search)[indexPath.row]
            self.recentCellTapped.accept(selectedItem)
            print(selectedItem)
        case 1:
            let selectedItem = recentDataSource.snapshot().itemIdentifiers(inSection: .character)[indexPath.row]
            self.recentCellTapped.accept(selectedItem)
            print(selectedItem)
        default:
            break
        }
    }
}
