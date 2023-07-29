//
//  HomeViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

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
    
    private var posterDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
    private var characterDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
    private var mbtiHeroDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
    private var recommendDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
    private var nowHotDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
    
    let categoryButtonTap = PublishSubject<String>()
    let posterCellSelected = PublishSubject<Void>()
    let mbtiMovieCellSelected = PublishSubject<Void>()
    let mbtiCharacterCellSelected = PublishSubject<Void>()
    let mbtiRecommendCellSeleted = PublishSubject<Void>()
    let hotMovieCellSelected = PublishSubject<Void>()
    let categoryTitle = PublishRelay<String>()
    let viewDidLoadTrigger = PublishRelay<Void>()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadTrigger.accept(())
        self.homeView.posterCollectionView.delegate = self
        self.homeView.characterCollectionView.delegate = self
        self.homeView.mbtiHeroCharacterCollectionView.delegate = self
        self.homeView.recommendCollectionView.delegate = self
        self.homeView.nowHotCollectionView.delegate = self
        
        setNavigation()
        setPosterDataSource()
        setMbtiHeroDataSource()
        setCharacterDataSource()
        setRecommendDataSource()
        setNowHotDataSource()
    }
    
    override func setupBinding() {
        let input = HomeViewModel.Input(categoryButtonTapped: self.categoryButtonTap, heroPlusButtonTapped: self.homeView.mbtiHeroMoreButton.rx.tap, characterPlusButtonTapped: self.homeView.characterMoreButton.rx.tap, mbtiRecommendPlusButtonTapped: self.homeView.recommendMoreButton.rx.tap, hotMoviePlusButtonTapped: self.homeView.nowHotMoreButton.rx.tap, posterCellSelected: posterCellSelected, mbtiMovieCellSelected: self.mbtiMovieCellSelected, mbtiCharacterCellSelected: self.mbtiCharacterCellSelected, mbtiRecommendCellSeleted: self.mbtiRecommendCellSeleted, hotMovieCellSelected: self.hotMovieCellSelected, viewDidLoad: self.viewDidLoadTrigger)
        
        let output = self.viewModel.transform(input: input)
        
        output.animationData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] data in
                guard let self = self else { return }
                print(data.count, "data 개수")
                var posterSnapshot = NSDiffableDataSourceSnapshot<Int, AnimationData>()
                var mbtiHeroSnapshot = NSDiffableDataSourceSnapshot<Int, AnimationData>()
                var characterSnapshot = NSDiffableDataSourceSnapshot<Int, AnimationData>()
                var recommendSnapshot = NSDiffableDataSourceSnapshot<Int, AnimationData>()
                var nowHotSnapshot = NSDiffableDataSourceSnapshot<Int, AnimationData>()
                posterSnapshot.appendSections([0])
                mbtiHeroSnapshot.appendSections([0])
                characterSnapshot.appendSections([0])
                recommendSnapshot.appendSections([0])
                nowHotSnapshot.appendSections([0])
                var section1Arr: [AnimationData] = []
                var section2Arr: [AnimationData] = []
                var section3Arr: [AnimationData] = []
                var section4Arr: [AnimationData] = []
                var section5Arr: [AnimationData] = []
                
                section1Arr.append(contentsOf: [data[0], data[1], data[2], data[3], data[4], data[5]])
                section2Arr.append(contentsOf: [data[6], data[7], data[8], data[9], data[10]])
                section3Arr.append(contentsOf: [data[11], data[12], data[13], data[14], data[15], data[16]])
                section4Arr.append(contentsOf: [data[17], data[18], data[19], data[20], data[21], data[22]])
                section5Arr.append(contentsOf: [data[23], data[24], data[25], data[26], data[27], data[28]])
                
                posterSnapshot.appendItems(section1Arr, toSection: 0)
                mbtiHeroSnapshot.appendItems(section2Arr, toSection: 0)
                characterSnapshot.appendItems(section3Arr, toSection: 0)
                recommendSnapshot.appendItems(section4Arr, toSection: 0)
                nowHotSnapshot.appendItems(section5Arr, toSection: 0)
                self.posterDataSource.apply(posterSnapshot)
                self.mbtiHeroDataSource.apply(mbtiHeroSnapshot)
                self.characterDataSource.apply(characterSnapshot)
                self.recommendDataSource.apply(recommendSnapshot)
                self.nowHotDataSource.apply(nowHotSnapshot)
            }
            .disposed(by: self.disposeBag)
        
        output.category
            .bind { [weak self] category in
                guard let self else { return }
                self.categoryTitle.accept(category)
            }
            .disposed(by: self.disposeBag)
    }
}

//MARK: PosterDataSource 설정
extension HomeViewController {
    func setPosterDataSource() {
        let cellPosterRegistration = UICollectionView.CellRegistration<PosterCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        posterDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.posterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellPosterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let todayDIMOHeader = UICollectionView.SupplementaryRegistration<TodayDIMOHeaderView>(elementKind: TodayDIMOHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        posterDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: todayDIMOHeader, for: indexPath)
            return header
        })
    }
}

//MARK: MbtiHeroDataSource 설정
extension HomeViewController {
    func setMbtiHeroDataSource() {
        let cellHeroCharacterRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        mbtiHeroDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.mbtiHeroCharacterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellHeroCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
            
        }
        
        mbtiHeroDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            
            return header
        })
    }
}

//MARK: CharacterDataSource 설정
extension HomeViewController {
    func setCharacterDataSource() {
        let cellCharacterRegistration = UICollectionView.CellRegistration<CircleCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier.characters[0])
        }
        
        characterDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.characterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
        }
        
        characterDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            
            return header
        })
    }
}

//MARK: RecommendDataSource 설정
extension HomeViewController {
    func setRecommendDataSource() {
        let cellRecommendRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        recommendDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.recommendCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRecommendRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
        }
        
        recommendDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            
            return header
        })
    }
}

//MARK: NowHotDataSource 설정
extension HomeViewController {
    func setNowHotDataSource() {
        let cellNowHotRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        nowHotDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.nowHotCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellNowHotRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
        }
        
        nowHotDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            
            return header
        })
    }
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch collectionView {
        case self.homeView.posterCollectionView:
                self.posterCellSelected.onNext(())
        case self.homeView.mbtiHeroCharacterCollectionView:
            self.mbtiMovieCellSelected.onNext(())
        case self.homeView.characterCollectionView:
            self.mbtiCharacterCellSelected.onNext(())
        case self.homeView.recommendCollectionView:
            self.mbtiRecommendCellSeleted.onNext(())
        case self.homeView.nowHotCollectionView:
            self.hotMovieCellSelected.onNext(())
        default:
            print("다른컬렉션뷰클릭함")
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

extension HomeViewController: UITabBarDelegate {
    
}
