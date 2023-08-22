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
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.collectionView.delegate = self
        setDataSource()
        self.selfView.configureCategoryUpdate(category: SearchCategoryCase.work.rawValue)
    }
    
    override func setupBinding() {
        let input = SearchViewModel.Input(viewDidLoad: Observable.just(()))
        
        let output = self.viewModel.transform(input: input)
        output.animationData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] data in
                guard let self = self else { return }
                print(data.count, "data 개수")
                var snapshot = NSDiffableDataSourceSnapshot<Int, AnimationData>()
                snapshot.appendSections([0, 1])
                var section1Arr: [AnimationData] = []
                var section2Arr: [AnimationData] = []
                
                section1Arr.append(contentsOf: [data[0], data[1], data[2], data[3], data[4], data[5], data[11], data[12]])
                section2Arr.append(contentsOf: [data[6], data[7], data[8], data[9], data[10]])

                
                snapshot.appendItems(section1Arr, toSection: 0)
                snapshot.appendItems(section2Arr, toSection: 1)

                self.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    func setDataSource() {
        let cellRecentSearchRegistration =
        UICollectionView.CellRegistration<RecentSearchCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        let cellRecentCharacterRegistration = UICollectionView.CellRegistration<VoteCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRecentSearchRegistration, for: indexPath, item: itemIdentifier)
                return cell
            default:

                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRecentCharacterRegistration, for: indexPath, item: itemIdentifier)
                
                return cell
            }
        }
        
        let headerView = UICollectionView.SupplementaryRegistration<SearchHeaderView>(elementKind: SearchHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            switch indexPath.section {
            case 0:
                supplementaryView.titleLabel.text = "최근 검색어"
            case 1:
                supplementaryView.titleLabel.text = "최근 본 캐릭터"
            default:
                supplementaryView.titleLabel.text = "error"
            }
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: headerView, for: indexPath)
            return header

        })
    }
}


extension SearchViewController: UICollectionViewDelegate {
    
}
