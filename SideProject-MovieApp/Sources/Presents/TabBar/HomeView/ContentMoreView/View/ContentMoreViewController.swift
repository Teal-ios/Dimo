//
//  ContentMoreViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import RxSwift
import RxCocoa

final class ContentMoreViewController: BaseViewController {
    let contentMoreView = ContentMoreView()
    
    private let viewModel: ContentMoreViewModel
    
    init(viewModel: ContentMoreViewModel, title: String) {
        self.viewModel = viewModel
        self.contentMoreView.titleLabel.text = title
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, HomeModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, HomeModel>()
    
    let cardCellSelected = PublishSubject<Void>()

    override func loadView() {
        view = contentMoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentMoreView.collectionView.delegate = self
        setDataSource()
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, HomeModel> { cell, indexPath, itemIdentifier in
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: contentMoreView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
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

extension ContentMoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCellSelected.onNext(())
    }
}
