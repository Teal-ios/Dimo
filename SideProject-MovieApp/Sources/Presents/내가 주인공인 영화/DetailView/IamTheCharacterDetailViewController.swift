//
//  IamTheCharacterDetailViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/23.
//

import UIKit

class IamTheCharacterDetailViewController: BaseViewController {
    let detailView = IamTheCharacterDetailView()
//    weak var coordinator: IamTheCharacterDetailCoordinator?
    
    var dataSource: UICollectionViewDiffableDataSource<Int, IamTheCharacterDetailModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, IamTheCharacterDetailModel>()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSource()
    }
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<IamTheCharacterDetailViewCell, IamTheCharacterDetailModel> { cell, indexPath, itemIdentifier in
            
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: detailView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        }
        snapshot.appendSections([0])
        var section1Arr: [IamTheCharacterDetailModel] = []
        for _ in 1..<100 {
            section1Arr.append(IamTheCharacterDetailModel())
        }
        snapshot.appendItems(section1Arr, toSection: 0)
       
        dataSource.apply(snapshot)
        print("count :", snapshot.itemIdentifiers.count)
    }

    
}
