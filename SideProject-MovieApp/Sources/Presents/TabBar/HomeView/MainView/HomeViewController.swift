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

enum Category: String {
    case poster = "represent"
    case hot = "hits"
    case mbtiChar = "same_mbti_char"
    case mbtiAnime = "same_mbti_anime"
    case recommend = "recommend"
}

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
    
    private var posterDataSource: UICollectionViewDiffableDataSource<Int, Hit>!
    private var characterDataSource: UICollectionViewDiffableDataSource<Int, SameMbtiCharacter>!
    private var mbtiHeroDataSource: UICollectionViewDiffableDataSource<Int, Hit>!
    private var recommendDataSource: UICollectionViewDiffableDataSource<Int, Hit>!
    private var nowHotDataSource: UICollectionViewDiffableDataSource<Int, Hit>!
    
    //    let categoryButtonTap = PublishSubject<String>()
    let posterCellSelected = PublishRelay<String>()
    let mbtiHeroCellSelected = PublishRelay<String>()
    //    let mbtiCharacterCellSelected = PublishSubject<Void>()
    let mbtiRecommendCellSeleted = PublishRelay<String>()
    let hotMovieCellSelected = PublishRelay<String>()
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
        let input = HomeViewModel.Input(categoryButtonTapped: self.homeView.categoryButton.rx.tap.withLatestFrom(self.categoryTitle).asSignal(onErrorJustReturn: "영화"), heroPlusButtonTapped: self.homeView.mbtiHeroMoreButton.rx.tap, characterPlusButtonTapped: self.homeView.characterMoreButton.rx.tap, mbtiRecommendPlusButtonTapped: self.homeView.recommendMoreButton.rx.tap, hotMoviePlusButtonTapped: self.homeView.nowHotMoreButton.rx.tap, posterCellSelected: posterCellSelected, mbtiHeroCellSelected: self.mbtiHeroCellSelected, mbtiRecommendCellSeleted: self.mbtiRecommendCellSeleted, hotMovieCellSelected: self.hotMovieCellSelected, viewDidLoad: self.viewDidLoadTrigger, okAlertButtonTapped: self.homeView.alertView.okButton.rx.tap, cancelAlertButtonTapped: self.homeView.alertView.cancelButton.rx.tap)
        
        let output = self.viewModel.transform(input: input)
        
        output.animationData
            .observe(on: MainScheduler.instance)
            .bind { animation in
                var posterSnapshot = NSDiffableDataSourceSnapshot<Int, Hit>()
                var mbtiHeroSnapshot = NSDiffableDataSourceSnapshot<Int, Hit>()
                var characterSnapshot = NSDiffableDataSourceSnapshot<Int, SameMbtiCharacter>()
                var recommendSnapshot = NSDiffableDataSourceSnapshot<Int, Hit>()
                var nowHotSnapshot = NSDiffableDataSourceSnapshot<Int, Hit>()
                posterSnapshot.appendSections([0])
                mbtiHeroSnapshot.appendSections([0])
                characterSnapshot.appendSections([0])
                recommendSnapshot.appendSections([0])
                nowHotSnapshot.appendSections([0])
                var posterArr: [Hit] = []
                var mbtiHeroArr: [Hit] = []
                var mbtiCharArr: [SameMbtiCharacter] = []
                var hotArr: [Hit] = []
                var recommendArr: [Hit] = []
                
                for content in animation.contents {
                    if content.category == Category.recommend.rawValue {
                        guard let recommend = content.recommend else { return }
                        recommendArr = recommend
                    }
                    if content.category == Category.mbtiAnime.rawValue {
                        guard let hero = content.same_mbti_anime else { return }
                        mbtiHeroArr = hero
                    }
                    if content.category == Category.mbtiChar.rawValue {
                        guard let char = content.same_mbti_char else { return }
                        mbtiCharArr = char
                    }
                    if content.category == Category.hot.rawValue {
                        guard let hit = content.hit else { return }
                        hotArr = hit
                    }
                    if content.category == Category.poster.rawValue {
                        guard let represent = content.represent else { return }
                        posterArr = represent
                    }
                }
                posterSnapshot.appendItems(posterArr, toSection: 0)
                mbtiHeroSnapshot.appendItems(mbtiHeroArr, toSection: 0)
                characterSnapshot.appendItems(mbtiCharArr, toSection: 0)
                recommendSnapshot.appendItems(recommendArr, toSection: 0)
                nowHotSnapshot.appendItems(hotArr, toSection: 0)
                self.posterDataSource.apply(posterSnapshot)
                self.mbtiHeroDataSource.apply(mbtiHeroSnapshot)
                self.characterDataSource.apply(characterSnapshot)
                self.recommendDataSource.apply(recommendSnapshot)
                self.nowHotDataSource.apply(nowHotSnapshot)
            }
            .disposed(by: disposeBag)
        
        output.category
            .bind { [weak self] category in
                guard let self else { return }
                self.categoryTitle.accept(category)
            }
            .disposed(by: self.disposeBag)
        
        output.characterPlusButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.homeView.updateSpoilerAlert(alertAppear: true)
            }
            .disposed(by: disposeBag)
        
        output.cancelAlertButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.homeView.updateSpoilerAlert(alertAppear: false)
            }
            .disposed(by: disposeBag)
        
        output.okAlertButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.homeView.updateSpoilerAlert(alertAppear: false)
            }
            .disposed(by: disposeBag)
    }
}

//MARK: PosterDataSource 설정
extension HomeViewController {
    func setPosterDataSource() {
        let cellPosterRegistration = UICollectionView.CellRegistration<PosterCollectionViewCell, Hit> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        posterDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.posterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellPosterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let todayDIMOHeader = UICollectionView.SupplementaryRegistration<TodayDIMOHeaderView>(elementKind: TodayDIMOHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            self.categoryTitle
                .debug()
                .bind { [weak self] title in
                    guard let self else { return }
                    supplementaryView.categoryInsetLabel.text = title
                }
                .disposed(by: self.disposeBag)
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
        let cellHeroCharacterRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, Hit> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        mbtiHeroDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.mbtiHeroCharacterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellHeroCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
            supplementaryView.titleLabel.text = "ISFJ가 주인공인 영화"
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
        let cellCharacterRegistration = UICollectionView.CellRegistration<CircleCollectionViewCell, SameMbtiCharacter> { cell, indexPath, itemIdentifier in
            cell.configureAttributeToSameMbtiCharacter(with: itemIdentifier)
        }
        
        characterDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.characterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
            supplementaryView.titleLabel.text = "스포주의! ISFJ 캐릭터 모아보기"
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
        let cellRecommendRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, Hit> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        recommendDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.recommendCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRecommendRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
            supplementaryView.titleLabel.text = "ISFJ가 관심있는 영화/애니"
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
        let cellNowHotRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, Hit> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        nowHotDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.nowHotCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellNowHotRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
            supplementaryView.titleLabel.text = "지금 핫한 영화"
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
            self.posterCellDataFetching(indexPath: indexPath)
        case self.homeView.mbtiHeroCharacterCollectionView:
            self.mbtiHeroCellDataFetching(indexPath: indexPath)
            //        case self.homeView.characterCollectionView:
            //            self.mbtiCharacterCellSelected.onNext(())
        case self.homeView.recommendCollectionView:
            self.mbtiRecommendCellDataFetching(indexPath: indexPath)
        case self.homeView.nowHotCollectionView:
            self.nowHotCellDataFetching(indexPath: indexPath)
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

extension HomeViewController {
    func posterCellDataFetching(indexPath: IndexPath) {
        let selectedItem = posterDataSource.snapshot().itemIdentifiers[indexPath.row]
        self.posterCellSelected.accept(String(selectedItem.anime_id))
    }
}

extension HomeViewController {
    func mbtiHeroCellDataFetching(indexPath: IndexPath) {
        let selectedItem = mbtiHeroDataSource.snapshot().itemIdentifiers[indexPath.row]
        self.mbtiHeroCellSelected.accept(String(selectedItem.anime_id))
    }
}

extension HomeViewController {
    func mbtiRecommendCellDataFetching(indexPath: IndexPath) {
        let selectedItem = recommendDataSource.snapshot().itemIdentifiers[indexPath.row]
        self.mbtiRecommendCellSeleted.accept(String(selectedItem.anime_id))
    }
}

extension HomeViewController {
    func nowHotCellDataFetching(indexPath: IndexPath) {
        let selectedItem = nowHotDataSource.snapshot().itemIdentifiers[indexPath.row]
        self.hotMovieCellSelected.accept(String(selectedItem.anime_id))
    }
}
