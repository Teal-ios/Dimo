//
//  CharacterMoreViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/23.
//

import UIKit
import RxSwift
import RxCocoa

final class CharacterMoreViewController: BaseViewController {
    let selfView = CharacterMoreView()
    
    private let viewModel: CharacterMoreViewModel
    
    init(viewModel: CharacterMoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, SameMbtiCharacter>!
    
    let characterCellSelected = PublishRelay<SameMbtiCharacter>()
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
        let input = CharacterMoreViewModel.Input(characterCellSelected: self.characterCellSelected)
        
        let output = self.viewModel.transform(input: input)
        
        Observable
            .zip(output.characters, self.viewDidLoadTrigger)
            .bind { [weak self] characters, _ in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Int, SameMbtiCharacter>()
                snapshot.appendSections([0])
                var characterArr: [SameMbtiCharacter] = []
                for ele in characters {
                    characterArr.append(ele)
                }
                snapshot.appendItems(characterArr, toSection: 0)
                self.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
    }
}

extension CharacterMoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.characterCellDataFetching(indexPath: indexPath)
    }
}

extension CharacterMoreViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<VoteCollectionViewCell, SameMbtiCharacter> { cell, indexPath, itemIdentifier in
            cell.configureSameMbtiCharacter(with: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
        })
    }
}

extension CharacterMoreViewController {
    private func characterCellDataFetching(indexPath: IndexPath) {
        let selectedItem = dataSource.snapshot().itemIdentifiers[indexPath.row]
        self.characterCellSelected.accept(selectedItem)
    }
}
