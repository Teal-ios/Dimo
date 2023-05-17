//
//  HomeViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    let homeView = HomeView()
    
    private var viewModel: HomeViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("HomeViewController: fatal error")
        
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, HomeModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, HomeModel>()
    
    let categoryButtonTap = PublishSubject<Void>()
    let posterCellSelected = PublishSubject<Void>()
    let heroPlusButtonTap = PublishSubject<Void>()
    let mbtiCharacterPlusButtonTap = PublishSubject<Void>()
    let mbtiRecommendPlusButtonTap = PublishSubject<Void>()
    let hotMoviePlusButtonTap = PublishSubject<Void>()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeView.collectionView.delegate = self
        setNavigation()
        setDataSource()
    }
    
    override func setupBinding() {
        let input = HomeViewModel.Input(categoryButtonTapped: self.categoryButtonTap, heroPlusButtonTapped: self.heroPlusButtonTap, characterPlusButtonTapped: self.mbtiCharacterPlusButtonTap, mbtiRecommendPlusButtonTapped: self.mbtiRecommendPlusButtonTap, hotMoviePlusButtonTapped: self.hotMoviePlusButtonTap, posterCellSelected: posterCellSelected)
        let output = self.viewModel.transform(input: input)
    }
    

    func setDataSource() {
        let cellPosterRegistration = UICollectionView.CellRegistration<PosterCollectionViewCell, HomeModel> { cell, indexPath, itemIdentifier in
        }
        
        let cellHeroCharacterRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, HomeModel> { cell, indexPath, itemIdentifier in
            
        }
        
        let cellCharacterRegistration = UICollectionView.CellRegistration<CircleCollectionViewCell, HomeModel> { cell, indexPath, itemIdentifier in
            
        }
        
        let cellRecommandRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, HomeModel> { cell, indexPath, itemIdentifier in
            
        }
        
        let cellHotRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, HomeModel> { cell, indexPath, itemIdentifier in
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: homeView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellPosterRegistration, for: indexPath, item: itemIdentifier)

                return cell
            case 1:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellHeroCharacterRegistration, for: indexPath, item: itemIdentifier)
                return cell
            case 2:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellCharacterRegistration, for: indexPath, item: itemIdentifier)
                return cell
            case 3:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRecommandRegistration, for: indexPath, item: itemIdentifier)
                return cell
            case 4:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellHotRegistration, for: indexPath, item: itemIdentifier)
                return cell
            default:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellHotRegistration, for: indexPath, item: itemIdentifier)
                return cell
            }
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            switch indexPath.section {
            case 1:
                supplementaryView.moreButton.rx.tap.bind(to: self.heroPlusButtonTap).disposed(by: self.disposeBag)
            case 2:
                supplementaryView.moreButton.rx.tap.bind(to: self.mbtiCharacterPlusButtonTap).disposed(by: self.disposeBag)
            case 3:
                supplementaryView.moreButton.rx.tap.bind(to: self.mbtiRecommendPlusButtonTap).disposed(by: self.disposeBag)
            case 4:
                supplementaryView.moreButton.rx.tap.bind(to: self.hotMoviePlusButtonTap).disposed(by: self.disposeBag)
            default:
                print("another Section")

            }
        }
        
        let todayDIMOHeader = UICollectionView.SupplementaryRegistration<TodayDIMOHeaderView>(elementKind: TodayDIMOHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            supplementaryView.categoryButton.rx.tap.bind(to: self.categoryButtonTap).disposed(by: self.disposeBag)

        }
        
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: todayDIMOHeader, for: indexPath)
                return header
            case 1:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "ISFJ가 주인공인 영화"
                return header
            case 2:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "스포주의! ISFJ 캐릭터 모아보기"
                return header
            case 3:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "ISFJ가 추천한 영화"
                return header
            case 4:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "지금 핫한 영화"
                return header
            default:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                header.titleLabel.text = "내가 쓴 댓글"
                return header
            }
        })
        
        snapshot.appendSections([0, 1, 2, 3, 4])
        var section1Arr: [HomeModel] = []
        var section2Arr: [HomeModel] = []
        var section3Arr: [HomeModel] = []
        var section4Arr: [HomeModel] = []
        var section5Arr: [HomeModel] = []

        
        for _ in 1..<50 {
            section1Arr.append(HomeModel(image: nil))
            section2Arr.append(HomeModel(image: nil))
            section3Arr.append(HomeModel(image: nil))
            section4Arr.append(HomeModel(image: nil))
            section5Arr.append(HomeModel(image: nil))
            
        }
        
        snapshot.appendItems(section1Arr, toSection: 0)
        snapshot.appendItems(section2Arr, toSection: 1)
        snapshot.appendItems(section3Arr, toSection: 2)
        snapshot.appendItems(section4Arr, toSection: 3)
        snapshot.appendItems(section5Arr, toSection: 4)
        dataSource.apply(snapshot)

    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            self.posterCellSelected.onNext(())
        default:
            print(indexPath.section)
        }
    }
}

extension HomeViewController {
    private func setNavigation() {
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named: "bell"), style: .plain, target: self, action: #selector(bellButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .black60
    }
    
    @objc
    func bellButtonTapped() {
        
    }
}
