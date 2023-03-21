//
//  IamTheMainCharacterViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/21.
//

import UIKit

class IamTheMainCharacterViewController: BaseViewController {
    let mainCharacterView = IamTheMainCharacterView()
    
    weak var coordinator: IamTheMainCharacterCoordinator?
    var dataSource: UICollectionViewDiffableDataSource<Int, IamTheMainCharacterModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, IamTheMainCharacterModel>()
    
    override func loadView() {
        view = mainCharacterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(describing: IamTheMainCharacterViewController.self))
        setDataSource()
    }

    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<IamTheMainCharacterCell, IamTheMainCharacterModel> { cell, indexPath, itemIdentifier in
            
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainCharacterView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        
            return cell
        }
        let header = UICollectionView.SupplementaryRegistration<IamTheMainCharacterHeader>(elementKind: IamTheMainCharacterHeader.identifier) { supplementaryView, elementKind, indexPath in
            switch indexPath.section {
            case 0:
                supplementaryView.label.text = "첫번째 섹션"
            default:
                supplementaryView.label.text = "나머지 섹션"
            }
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: header, for: indexPath)
            return header
        })
        
        snapshot.appendSections([0, 1, 2])
        var section1Arr: [IamTheMainCharacterModel] = []
        var section2Arr: [IamTheMainCharacterModel] = []
        var section3Arr: [IamTheMainCharacterModel] = []
        for i in 1..<100 {
            section1Arr.append(IamTheMainCharacterModel())
            section2Arr.append(IamTheMainCharacterModel())
            section3Arr.append(IamTheMainCharacterModel())
        }
        snapshot.appendItems(section1Arr, toSection: 0)
        snapshot.appendItems(section2Arr, toSection: 1)
        snapshot.appendItems(section3Arr, toSection: 2)
        dataSource.apply(snapshot)
    }
    

}
