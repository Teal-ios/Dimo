//
//  MyMomentumViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import RxCocoa
import RxSwift

class MyMomentumViewController: BaseViewController {
    private let myMomentumView = MyMomentumView()
    
    private var viewModel: MyMomentumViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("MyMomentumViewController: fatal error")
    }
    
    init(viewModel: MyMomentumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    let viewDidLoadTrigger = PublishRelay<Void>()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, MyMomentumModel>!
    private var snapshot = NSDiffableDataSourceSnapshot<Int, MyMomentumModel>()
    
    override func loadView() {
        view = myMomentumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadTrigger.accept(())
        setupBinding()
        setNavigation()
        setDataSource()
    }
    
    override func setupBinding() {
        let input = MyMomentumViewModel.Input(viewDidLoad: self.viewDidLoadTrigger)

        
        let output = viewModel.transform(input: input)
    }
}

extension MyMomentumViewController {
    func setDataSource() {
        let cellLikeContentRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, MyMomentumModel> { cell, indexPath, itemIdentifier in
        }
        
        let cellDigFinishCharacterRegistration = UICollectionView.CellRegistration<DigFinishCharacterCollectionViewCell, MyMomentumModel> { cell, indexPath, itemIdentifier in
            
        }
        
        let cellReviewRegistration = UICollectionView.CellRegistration<ReviewCollectionViewCell, MyMomentumModel> { cell, indexPath, itemIdentifier in
            
        }
        
        let cellCommentRegistration = UICollectionView.CellRegistration<ReviewCollectionViewCell, MyMomentumModel> { cell, indexPath, itemIdentifier in
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: myMomentumView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellLikeContentRegistration, for: indexPath, item: itemIdentifier)
                return cell
            case 1:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellDigFinishCharacterRegistration, for: indexPath, item: itemIdentifier)
                return cell
            case 2:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellReviewRegistration, for: indexPath, item: itemIdentifier)
                return cell
            case 3:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellCommentRegistration, for: indexPath, item: itemIdentifier)
                return cell
            default:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellCommentRegistration, for: indexPath, item: itemIdentifier)
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
            case 1:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "Dig 완료한 캐릭터"
                return header
            case 2:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "내가 쓴 리뷰"
                return header
            case 3:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "내가 쓴 댓글"
                return header
            default:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "내가 쓴 댓글"
                return header

            }
        })
        
        snapshot.appendSections([0, 1, 2, 3])
        var section1Arr: [MyMomentumModel] = []
        var section2Arr: [MyMomentumModel] = []
        var section3Arr: [MyMomentumModel] = []
        var section4Arr: [MyMomentumModel] = []
        
        
        for _ in 1..<50 {
            section1Arr.append(MyMomentumModel(image: nil))
            section2Arr.append(MyMomentumModel(image: nil))
            section3Arr.append(MyMomentumModel(image: nil))
            section4Arr.append(MyMomentumModel(image: nil))
        }
        
        snapshot.appendItems(section1Arr, toSection: 0)
        snapshot.appendItems(section2Arr, toSection: 1)
        snapshot.appendItems(section3Arr, toSection: 2)
        snapshot.appendItems(section4Arr, toSection: 3)
        dataSource.apply(snapshot)
    }
}

extension MyMomentumViewController {
    private func setNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "bell"), style: .plain, target: self, action: #selector(bellButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .black60
    }
    
    @objc
    func bellButtonTapped() {
        
    }
}
