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
    
    var dataSource: UICollectionViewDiffableDataSource<Int, FeedDetailModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, FeedDetailModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSource()
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
