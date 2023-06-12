//
//  MovieDetailViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieDetailViewController: BaseViewController {
    let selfView = MovieDetailView()
    
    private let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, HomeModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, HomeModel>()
    
    let characterCellSelected = PublishSubject<Void>()

    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selfView.characterCollectionView.delegate = self
        setDataSource()
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CircleCollectionViewCell, HomeModel> { cell, indexPath, itemIdentifier in
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.characterCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let characterHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: characterHeader, for: indexPath)
            return header
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

extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.characterCellSelected.onNext(())
    }
}

