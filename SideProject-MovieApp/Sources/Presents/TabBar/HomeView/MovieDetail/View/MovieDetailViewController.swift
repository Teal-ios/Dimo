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
    
    var dataSource: UICollectionViewDiffableDataSource<Int, HomeModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, HomeModel>()
    
    let characterCellSelected = PublishSubject<Void>()
    let evaluateButtonTapped = PublishSubject<Void>()


    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selfView.characterCollectionView.delegate = self
        setDataSource()
    }
    
    override func setupBinding() {
        let input = MovieDetailViewModel.Input(plusButtonTapped: self.selfView.unfoldButton.rx.tap, evaluateButtonTapped: self.evaluateButtonTapped)
        let output = self.viewModel.transform(input: input)
        
        output.plusButtonTapped.bind { [weak self] _ in
            if self?.selfView.unfoldStackView.isHidden == true {
                self?.selfView.changeIsHidden(isHidden: false)
            } else {
                self?.selfView.changeIsHidden(isHidden: true)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CharacterMbtiCollectionViewCell, HomeModel> { cell, indexPath, itemIdentifier in
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.characterCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let characterHeader = UICollectionView.SupplementaryRegistration<MovieDetailHeaderView>(elementKind: MovieDetailHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            supplementaryView.evaluateButton.rx.tap.bind { [weak self] _ in
                self?.evaluateButtonTapped.onNext(())
            }
            .disposed(by: self.disposeBag)
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

