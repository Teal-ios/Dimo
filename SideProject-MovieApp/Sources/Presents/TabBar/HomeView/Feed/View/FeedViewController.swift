//
//  FeedViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import RxSwift
import RxCocoa

final class FeedViewController: BaseViewController {
    let selfView = FeedView()
    
    private var viewModel: FeedViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("FeedViewController: fatal error")
    }
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, ReviewList>!
    
    let reviewCellSelected = PublishRelay<ReviewList>()
    let viewDidLoadTrigger = PublishRelay<Void>()
    let viewWillAppearTrigger = PublishRelay<Void>()
    let feedButtonCellSelected = PublishRelay<ReviewList>()
    
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
        self.viewWillAppearTrigger.accept(())
    }
    
    override func setupBinding() {
        let input = FeedViewModel.Input(reviewCellSelected: self.reviewCellSelected, writeButtonTapped: self.selfView.writeButton.rx.tap, viewDidLoad: self.viewDidLoadTrigger, viewWillAppear: self.viewWillAppearTrigger, feedButtonCellSelected: self.feedButtonCellSelected)
        
        let output = self.viewModel.transform(input: input)
        
        output.getReivewList
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, getReviewList in
                if getReviewList.review_list == [] {
                    vc.selfView.reviewException(data: false)
                } else {
                    var reviewSnapshot = NSDiffableDataSourceSnapshot<Int, ReviewList>()
                    reviewSnapshot.appendSections([0])
                    var sectionArr: [ReviewList] = []
                    for i in getReviewList.review_list {
                        guard let i = i else { return }
                        sectionArr.append(i)
                    }
                    reviewSnapshot.appendItems(sectionArr, toSection: 0)
                    self.dataSource.apply(reviewSnapshot)
                    vc.selfView.reviewException(data: true)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension FeedViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FeedReviewCollectionViewCell, ReviewList> { cell, indexPath, itemIdentifier in
            cell.configureUI(with: itemIdentifier)
            
            cell.feedButton.rx
                .tap
                .debug()
                .withUnretained(self)
                .bind { vc, _ in
                    vc.feedButtonCellSelected.accept(itemIdentifier)
                    cell.disposeBag = DisposeBag()
                }
                .disposed(by: cell.disposeBag)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        
//        snapshot.appendSections([0])
//        var section1Arr: [VoteModel] = []
//
//        for _ in 1..<100 {
//            section1Arr.append(VoteModel(image: UIImage(named: "CharacterRandom")))
//        }
//
//        snapshot.appendItems(section1Arr, toSection: 0)
//        dataSource.apply(snapshot)
    }
}

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dataFetchingToReviewCell(indexPath: indexPath)
    }
}

extension FeedViewController {
    func dataFetchingToReviewCell(indexPath: IndexPath) {
        let selectedItem = dataSource.snapshot().itemIdentifiers[indexPath.row]
        self.reviewCellSelected.accept(selectedItem)
    }
}
