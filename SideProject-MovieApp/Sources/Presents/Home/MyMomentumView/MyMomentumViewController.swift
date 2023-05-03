//
//  MyMomentumViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit

class MyMomentumViewController: BaseViewController {
    let myMomentumView = MyMomentumView()
    
    private var viewModel: MyMomentumViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("MyMomentumViewController: fatal error")
    }
    
    init(viewModel: MyMomentumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, MyMomentumModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, MyMomentumModel>()
    
    override func loadView() {
        view = myMomentumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSource()
    }

    func setDataSource() {
        let cellLikeContentRegistration = UICollectionView.CellRegistration<LikeContentCollectionViewCell, MyMomentumModel> { cell, indexPath, itemIdentifier in
        }
        
        let cellDigFinishCharacterRegistration = UICollectionView.CellRegistration<DigFinishCharacterCollectionViewCell, MyMomentumModel> { cell, indexPath, itemIdentifier in
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: myMomentumView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellLikeContentRegistration, for: indexPath, item: itemIdentifier)
                return cell
            default:

                let cell = collectionView.dequeueConfiguredReusableCell(using: cellDigFinishCharacterRegistration, for: indexPath, item: itemIdentifier)
                return cell
            }
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        let ProfileHeader = UICollectionView.SupplementaryRegistration<ProfileHeaderView>(elementKind: ProfileHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: ProfileHeader, for: indexPath)
                return header
            default:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "Dig 완료한 캐릭터"
                return header

            }
        })
        
        snapshot.appendSections([0, 1])
        var section1Arr: [MyMomentumModel] = []
        var section2Arr: [MyMomentumModel] = []
        
        
        for _ in 1..<100 {
            section1Arr.append(MyMomentumModel(image: nil))
            section2Arr.append(MyMomentumModel(image: nil))
        }
        
        snapshot.appendItems(section1Arr, toSection: 0)
        snapshot.appendItems(section2Arr, toSection: 1)
        dataSource.apply(snapshot)
    }
}
