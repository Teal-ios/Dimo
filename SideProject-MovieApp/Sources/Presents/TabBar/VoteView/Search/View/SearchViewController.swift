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
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Result>!
    
    override func loadView() {
        view = selfView
    }
    
    let searchTextEditFinish = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.collectionView.delegate = self
        self.selfView.searchTextField.delegate = self
        setDataSource()
        self.selfView.configureCategoryUpdate(category: SearchCategoryCase.work.rawValue)
        self.selfView.updateCategoryView(categoryAppear: false)
    }
    
    override func setupBinding() {
        let input = SearchViewModel.Input(viewDidLoad: Observable.just(()), searchText: self.selfView.searchTextField.rx.text, searchTextEditFinish: self.searchTextEditFinish, searchCategoryButtonTapped: self.selfView.categoryButton.rx.tap)
        
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
                snapshot.appendItems(characterArr, toSection: 0)
                vc.dataSource.apply(snapshot)
                vc.selfView.updateCategoryView(categoryAppear: true)
                vc.selfView.configureCategoryUpdate(category: SearchCategoryCase.character.rawValue)
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


extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextEditFinish.accept(())
        return true
    }
}
