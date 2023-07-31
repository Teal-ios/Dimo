//
//  MovieDetailViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class MovieDetailViewController: BaseViewController {
    let selfView = MovieDetailView()
    
    private let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Characters>!
    
    let characterCellSelected = PublishRelay<Characters>()
    let evaluateButtonTapped = PublishSubject<Void>()
    let animationData = PublishRelay<DetailAnimationData>()
    let likeContentCheckTrigger = PublishRelay<Bool>()
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.characterCollectionView.delegate = self
        setDataSource()

    }
    
    override func setupBinding() {
        let input = MovieDetailViewModel.Input(plusButtonTapped: self.selfView.unfoldButton.rx.tap, evaluateButtonTapped: self.selfView.headerView.evaluateButton.rx.tap, likeButtonTapped: self.selfView.headerView.likeButton.rx.tap, likeContentCheckValid: self.likeContentCheckTrigger, characterCellSelected: self.characterCellSelected)
        let output = self.viewModel.transform(input: input)
        
        output.plusButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            if self.selfView.unfoldStackView.isHidden == true {
                self.selfView.changeIsHidden(isHidden: false)
            } else {
                self.selfView.changeIsHidden(isHidden: true)
            }
        }
        .disposed(by: disposeBag)
        
        output.animationData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] animationData in
                guard let self else { return }
                self.animationData.accept(animationData)
                self.selfView.configureUpdateUI(animationData: animationData)
                self.selfView.headerView.configureUpdateUI(animationData: animationData)
            }
            .disposed(by: disposeBag)
        
        output.characterData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] characters in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Int, Characters>()
                snapshot.appendSections([0])
                var sectionArr: [Characters] = characters
                snapshot.appendItems(sectionArr, toSection: 0)
                self.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
        
        output.likeButtonTapped
            .debug()
            .bind { [weak self] _ in
                guard let self else { return }
                if self.selfView.headerView.likeButton.image(for: .normal) == UIImage(named: "LikeNonSelect") {
                    print("몇번울리니")
                    self.likeContentCheckTrigger.accept(false)
                } else {
                    print("몇번울리니")
                    self.likeContentCheckTrigger.accept(true)
                }
            }
            .disposed(by: disposeBag)
        
        output.likeChoice
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
            guard let self else { return }
            self.selfView.headerView.updateLikeButtonUI(like: true)
        }
        .disposed(by: disposeBag)
        
        output.likeCancel
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                guard let self else { return }
                self.selfView.headerView.updateLikeButtonUI(like: false)
        }
        .disposed(by: disposeBag)
        
        output.likeContentCheck
            .observe(on: MainScheduler.instance)
            .bind { [weak self] likeContent in
                guard let self else { return }
                switch likeContent.code {
                case 200:
                    self.selfView.headerView.updateLikeButtonUI(like: true)
                case 201:
                    self.selfView.headerView.updateLikeButtonUI(like: false)
                default:
                    return
                }
            }
            .disposed(by: disposeBag)
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CharacterMbtiCollectionViewCell, Characters> { cell, indexPath, itemIdentifier in
            cell.configureUpdateUI(characterData: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.characterCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let characterHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            supplementaryView.titleLabel.text = "등장인물"
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: characterHeader, for: indexPath)
            return header
        })
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.characterCellDataFetching(indexPath: indexPath)
    }
}

extension MovieDetailViewController {
    func characterCellDataFetching(indexPath: IndexPath) {
        let selectedItem = dataSource.snapshot().itemIdentifiers[indexPath.row]
        self.characterCellSelected.accept(selectedItem)
    }
}
