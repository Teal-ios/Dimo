//
//  MyCharacterMoreViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa

final class MyCharacterMoreViewController: BaseViewController {
    let selfView = MyCharacterMoreView()
    
    private let viewModel: MyCharacterMoreViewModel
    
    init(viewModel: MyCharacterMoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, MyVotedCharacter>!
    
    let cardCellSelected = PublishRelay<Void>()
    let viewDidLoadTrigger = PublishRelay<Void>()
    let myDigCharacterCellSelected = PublishRelay<MyVotedCharacter>()

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
        let input = MyCharacterMoreViewModel.Input(myDigCharacterCellSelected: self.myDigCharacterCellSelected)
        
        let output = self.viewModel.transform(input: input)
        
        Observable
            .zip(output.characters, self.viewDidLoadTrigger)
            .bind { [weak self] characters, _ in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Int, MyVotedCharacter>()
                snapshot.appendSections([0])
                var characterArr: [MyVotedCharacter] = []
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

extension MyCharacterMoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.myDigCharacterCellDataFetching(indexPath: indexPath)
    }
}

extension MyCharacterMoreViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<VoteCollectionViewCell, MyVotedCharacter> { cell, indexPath, itemIdentifier in
            cell.configureAttributeWithVotedCharacter(with: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
        })
    }
}

extension MyCharacterMoreViewController {
    private func myDigCharacterCellDataFetching(indexPath: IndexPath) {
        let selectedItem = dataSource.snapshot().itemIdentifiers[indexPath.row]
        self.myDigCharacterCellSelected.accept(selectedItem)
    }
}
