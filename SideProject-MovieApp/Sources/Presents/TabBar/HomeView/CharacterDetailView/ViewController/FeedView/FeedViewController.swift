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
    let feedView = FeedView()
    
    private var viewModel: FeedViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("FeedViewController: fatal error")
    }
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, VoteModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, VoteModel>()
    
    let reviewCellSelected = PublishSubject<Void>()
    
    override func loadView() {
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedView.collectionView.delegate = self
        setDataSource()
    }
    
    override func setupBinding() {
        let input = FeedViewModel.Input(reviewCellSelected: self.reviewCellSelected)
        let output = self.viewModel.transform(input: input)
        
    }
}

extension FeedViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FeedReviewCollectionViewCell, VoteModel> { cell, indexPath, itemIdentifier in
            cell.imgView.image = itemIdentifier.image
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: feedView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        
        snapshot.appendSections([0])
        var section1Arr: [VoteModel] = []
                
        for _ in 1..<100 {
            section1Arr.append(VoteModel(image: UIImage(named: "CharacterRandom")))
        }
        
        snapshot.appendItems(section1Arr, toSection: 0)
        dataSource.apply(snapshot)
    }
}

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.reviewCellSelected.onNext(())
        
        //이부분을 어떻게 뺄 지 고민해보기
        //let vc = FeedDetailViewController(viewModel: FeedDetailViewModel())
        //self.navigationController?.pushViewController(vc, animated: true)
    }
}
