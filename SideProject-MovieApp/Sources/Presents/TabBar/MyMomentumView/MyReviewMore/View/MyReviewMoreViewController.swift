//
//  MyReviewMoreViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa

final class MyReviewMoreViewController: BaseViewController {
    let selfView = MyReviewMoreView()
    
    private let viewModel: MyReviewMoreViewModel
    
    init(viewModel: MyReviewMoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, MyReview>!
    
    let cardCellSelected = PublishRelay<Void>()
    let viewDidLoadTrigger = PublishRelay<Void>()

    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.collectionView.delegate = self
        setDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func setupBinding() {
        let input = MyReviewMoreViewModel.Input()
        
        let output = self.viewModel.transform(input: input)
        
        Observable
            .zip(output.myReview, self.viewDidLoadTrigger)
            .bind { [weak self] review, _ in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Int, MyReview>()
                snapshot.appendSections([0])
                var reviewArr: [MyReview] = []
                for ele in review {
                    guard let ele = ele else { return }
                    reviewArr.append(ele)
                }
                snapshot.appendItems(reviewArr, toSection: 0)
                self.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
    }
}

extension MyReviewMoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCellSelected.accept(())
    }
}

extension MyReviewMoreViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ReviewCollectionViewCell, MyReview> { cell, indexPath, itemIdentifier in
            cell.configureUpdateReviewDate(review: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
        })
    }
}
