//
//  FeedDetailViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import RxSwift
import RxCocoa

class FeedDetailViewController: BaseViewController {
    private let feedDetailView = FeedDetailView()
    
    private var viewModel: FeedDetailViewModel
    
    override func loadView() {
        view = feedDetailView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("FeedDetailViewController: fatal error")
        
    }
    
    init(viewModel: FeedDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    var categoryDataSource: UICollectionViewDiffableDataSource<Int, CategoryModel>!
    var categorySnapshot = NSDiffableDataSourceSnapshot<Int, CategoryModel>()

    
    var dataSource: UICollectionViewDiffableDataSource<Int, FeedDetailModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, FeedDetailModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryDataSource()
        setDataSource()
    }
}

extension FeedDetailViewController {
    func setCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CategoryCollectionViewCell, CategoryModel> {  cell, indexPath, itemIdentifier in
            cell.categoryLabel.text = itemIdentifier.category
            if itemIdentifier.spoil == true {
                cell.bgView.backgroundColor = .purple20
                cell.categoryLabel.textColor = .purple100
            }
        }
        
        categoryDataSource = UICollectionViewDiffableDataSource(collectionView: feedDetailView.categoryCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        categorySnapshot.appendSections([0])
        var categoryArr: [CategoryModel] = []
        
        categoryArr.append(CategoryModel(category: "스포주의", spoil: true))
        categoryArr.append(CategoryModel(category: "정대만", spoil: false))
        categoryArr.append(CategoryModel(category: "ENTP", spoil: false))
        categoryArr.append(CategoryModel(category: "더퍼스트슬램덩크", spoil: false))


        categorySnapshot.appendItems(categoryArr, toSection: 0)
        categoryDataSource.apply(categorySnapshot)
    }
}

extension FeedDetailViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DetailReviewCollectionViewCell, FeedDetailModel> {  cell, indexPath, itemIdentifier in
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: feedDetailView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let header = UICollectionView.SupplementaryRegistration<FeedDetailHeaderView>(elementKind: FeedDetailHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: header, for: indexPath)
            return header
        })
        
        snapshot.appendSections([0])
        var reviewArr: [FeedDetailModel] = []
        
        for _ in 1..<20 {
            reviewArr.append(FeedDetailModel(image: nil))
        }
        snapshot.appendItems(reviewArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}
