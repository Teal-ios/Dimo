//
//  MovieCharacterMoreViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieCharacterMoreViewController: BaseViewController {
    let selfView = MovieCharacterMoreView()
    
    private let viewModel: MovieCharacterMoreViewModel
    
    init(viewModel: MovieCharacterMoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Characters>!
    
    let cardCellSelected = PublishRelay<Void>()
    let viewDidLoadTrigger = PublishRelay<Void>()

    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.collectionView.delegate = self
        setDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func setupBinding() {
        let input = MovieCharacterMoreViewModel.Input()
        
        let output = self.viewModel.transform(input: input)
        
        Observable
            .zip(output.characters, self.viewDidLoadTrigger)
            .bind { [weak self] characters, _ in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Int, Characters>()
                snapshot.appendSections([0])
                var characterArr: [Characters] = []
                for ele in characters {
                    guard let ele = ele else { return }
                    characterArr.append(ele)
                }
                snapshot.appendItems(characterArr, toSection: 0)
                self.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
    }
}

extension MovieCharacterMoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCellSelected.accept(())
    }
}

extension MovieCharacterMoreViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<VoteCollectionViewCell, Characters> { cell, indexPath, itemIdentifier in
            cell.configureAttributeWithCharacters(with: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
        })
    }
}
