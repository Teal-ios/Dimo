//
//  VoteAnotherCharacterViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/10.
//

import UIKit
import RxSwift
import RxCocoa

final class VoteAnotherCharacterViewController: BaseViewController {
    let selfView = VoteAnotherCharacterView()
    
    private let viewModel: VoteAnotherCharacterViewModel
    
    init(viewModel: VoteAnotherCharacterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Result>!
    
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
        let input = VoteAnotherCharacterViewModel.Input()
        
        let output = self.viewModel.transform(input: input)
        
        Observable
            .zip(output.characters, self.viewDidLoadTrigger)
            .bind { [weak self] characters, _ in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Int, Result>()
                snapshot.appendSections([0])
                var characterArr: [Result] = []
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

extension VoteAnotherCharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCellSelected.accept(())
    }
}

extension VoteAnotherCharacterViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<VoteCollectionViewCell, Result> { cell, indexPath, itemIdentifier in
            cell.configureAttributeWithResult(with: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
        })
    }
}
