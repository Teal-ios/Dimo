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
    
    let categoryButtonTap = PublishSubject<String>()
    let posterCellSelected = PublishSubject<Void>()
    let mbtiMovieCellSelected = PublishSubject<Void>()
    let mbtiCharacterCellSelected = PublishSubject<Void>()
    let mbtiRecommendCellSeleted = PublishSubject<Void>()
    let hotMovieCellSelected = PublishSubject<Void>()
    let heroPlusButtonTap = PublishSubject<Void>()
    let mbtiCharacterPlusButtonTap = PublishSubject<Void>()
    let mbtiRecommendPlusButtonTap = PublishSubject<Void>()
    let hotMoviePlusButtonTap = PublishSubject<Void>()
    let categoryTitle = PublishRelay<String>()
    let viewDidLoadTrigger = PublishRelay<Void>()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadTrigger.accept(())
        self.homeView.collectionView.delegate = self
        
        setNavigation()
        setDataSource()
    }
    
    override func setupBinding() {
        let input = HomeViewModel.Input(categoryButtonTapped: self.categoryButtonTap, heroPlusButtonTapped: self.heroPlusButtonTap, characterPlusButtonTapped: self.mbtiCharacterPlusButtonTap, mbtiRecommendPlusButtonTapped: self.mbtiRecommendPlusButtonTap, hotMoviePlusButtonTapped: self.hotMoviePlusButtonTap, posterCellSelected: posterCellSelected, mbtiMovieCellSelected: self.mbtiMovieCellSelected, mbtiCharacterCellSelected: self.mbtiCharacterCellSelected, mbtiRecommendCellSeleted: self.mbtiRecommendCellSeleted, hotMovieCellSelected: self.hotMovieCellSelected, viewDidLoad: self.viewDidLoadTrigger)
        let output = self.viewModel.transform(input: input)
        
        output.animationData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] data in
                guard let self = self else { return }
                print(data.count, "data 개수")
                var snapshot = NSDiffableDataSourceSnapshot<Int, AnimationData>()
                snapshot.appendSections([0, 1, 2, 3, 4])
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

                
                print(section1Arr, "포스터 배열")
                print(section5Arr, "섹션5")
                snapshot.appendItems(section1Arr, toSection: 0)
                snapshot.appendItems(section2Arr, toSection: 1)
                snapshot.appendItems(section3Arr, toSection: 2)
                snapshot.appendItems(section4Arr, toSection: 3)
                snapshot.appendItems(section5Arr, toSection: 4)
                self.posterDataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
        
        output.category.bind { [weak self] category in
            guard let self else { return }
            self.categoryTitle.accept(category)
        }
        .disposed(by: self.disposeBag)
    }
}
//MARK: DataSource 관련
extension HomeViewController {
    func setDataSource() {
        let cellPosterRegistration = UICollectionView.CellRegistration<PosterCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        let cellHeroCharacterRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        let cellCharacterRegistration = UICollectionView.CellRegistration<CircleCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier.characters[0])
        }
        
        let cellRecommandRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        let cellHotRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        posterDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.collectionView) { collectionView, indexPath, itemIdentifier in
            
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
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { [weak self] supplementaryView, elementKind, indexPath in
            guard let self else { return }
            switch indexPath.section {
            case 1:
                supplementaryView.moreButton.rx.tap.bind { [weak self] _ in
                    guard let self else { return }
                    self.heroPlusButtonTap.onNext(())
                }
                .disposed(by: self.disposeBag)
            case 2:
                supplementaryView.moreButton.rx.tap.bind { [weak self] _ in
                    guard let self else { return }
                    self.mbtiCharacterPlusButtonTap.onNext(())
                }
                .disposed(by: self.disposeBag)
            case 3:
                supplementaryView.moreButton.rx.tap.bind { [weak self] _ in
                    guard let self else { return }
                    self.mbtiRecommendPlusButtonTap.onNext(())
                }
                .disposed(by: self.disposeBag)
            case 4:
                supplementaryView.moreButton.rx.tap.bind { [weak self] _ in
                    guard let self else { return }
                    self.hotMoviePlusButtonTap.onNext(())
                }
                .disposed(by: self.disposeBag)
            default:
                print("another Section")

            }
        }
        
        let todayDIMOHeader = UICollectionView.SupplementaryRegistration<TodayDIMOHeaderView>(elementKind: TodayDIMOHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            
            supplementaryView.categoryButton.rx.tap.bind { [weak self] _ in
                guard let self else { return }
                let categoryOnTitle = supplementaryView.categoryInsetLabel.text ?? ""
                self.categoryButtonTap.onNext(categoryOnTitle)
            }
            .disposed(by: self.disposeBag)
            
            self.categoryTitle.bind { [weak self] category in
                guard let self else { return }
                print(category, "카테고리 타이틀 변경될때마다 확인")
                supplementaryView.categoryInsetLabel.text = category
            }
            .disposed(by: self.disposeBag)

        }
        
        
        posterDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
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

    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            self.posterCellSelected.onNext(())
        case 1:
            self.mbtiMovieCellSelected.onNext(())
        case 2:
            print(indexPath.section)
            self.mbtiCharacterCellSelected.onNext(())
        case 3:
            self.mbtiRecommendCellSeleted.onNext(())
        case 4:
            self.hotMovieCellSelected.onNext(())
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

extension HomeViewController: UITabBarDelegate {
    
}
