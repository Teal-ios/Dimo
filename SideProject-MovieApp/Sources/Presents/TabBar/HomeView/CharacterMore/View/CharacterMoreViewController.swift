//
//  CharacterMoreViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/23.
//

import UIKit
import RxSwift
import RxCocoa

final class CharacterMoreViewController: BaseViewController {
    let selfView = CharacterMoreView()
    
    private let viewModel: CharacterMoreViewModel
    
    init(viewModel: CharacterMoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, HomeModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, HomeModel>()
    
    let cardCellSelected = PublishSubject<Void>()

    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selfView.collectionView.delegate = self
        setDataSource()
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<VoteCollectionViewCell, HomeModel> { cell, indexPath, itemIdentifier in
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
        })
     
        snapshot.appendSections([0])
        var movieArr: [HomeModel] = []
        for _ in 1..<50 {
            movieArr.append(HomeModel(image: nil))
        }
        
        snapshot.appendItems(movieArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}

extension CharacterMoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCellSelected.onNext(())
    }
}
