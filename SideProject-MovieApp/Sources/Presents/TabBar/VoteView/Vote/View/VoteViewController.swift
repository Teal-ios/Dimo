//
//  VoteViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import UIKit
import RxSwift
import RxCocoa

final class VoteViewController: BaseViewController {
    private let voteView = VoteView()
    
    private var viewModel: VoteViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("VoteViewController: fatal error")
    }
    
    init(viewModel: VoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, VoteModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, VoteModel>()
    
    let characterRandomRecommandCellSelected = PublishSubject<Void>()
    let characterSearchCellSelected = PublishSubject<Void>()
    
    override func loadView() {
        view = voteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.voteView.collectionView.delegate = self
        setDataSource()
    }
    
    override func setupBinding() {
        let input = VoteViewModel.Input(characterRandomRecommandCellTapped: self.characterRandomRecommandCellSelected, characterSearchCellTapped: self.characterSearchCellSelected)
        
        let _ = viewModel.transform(input: input)
    }
    
    func setDataSource() {
        let cellCharacterRegistration = UICollectionView.CellRegistration<CharacterRecommandAndSearchCollectionViewCell, VoteModel> { cell, indexPath, itemIdentifier in
            cell.imgView.image = itemIdentifier.image
        }
        
        let cellVoteRegistration = UICollectionView.CellRegistration<VoteCollectionViewCell, VoteModel> { cell, indexPath, itemIdentifier in
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: voteView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellCharacterRegistration, for: indexPath, item: itemIdentifier)
                return cell
            default:

                let cell = collectionView.dequeueConfiguredReusableCell(using: cellVoteRegistration, for: indexPath, item: itemIdentifier)
                return cell
            }
        }
        
        let voteHeader = UICollectionView.SupplementaryRegistration<VoteHeaderView>(elementKind: VoteHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }

        let characterHeader = UICollectionView.SupplementaryRegistration<CharacterRecommandAndSearchHeaderView>(elementKind: CharacterRecommandAndSearchHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: characterHeader, for: indexPath)
                return header
            default:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: voteHeader, for: indexPath)
                return header

            }
        })
        
        snapshot.appendSections([0, 1])
        var section1Arr: [VoteModel] = []
        var section2Arr: [VoteModel] = []
        
        section1Arr.append(VoteModel(image: UIImage(named: "CharacterRandom")))
        section1Arr.append(VoteModel(image: UIImage(named: "CharacterSearch")))
        
        for _ in 1..<100 {
            section2Arr.append(VoteModel(image: nil))
        }
        
        snapshot.appendItems(section1Arr, toSection: 0)
        snapshot.appendItems(section2Arr, toSection: 1)
        dataSource.apply(snapshot)
    }
}

extension VoteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("이게왜안울려", indexPath.section)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                print("이게울려?")
                self.characterRandomRecommandCellSelected.onNext(())
            } else {
                self.characterSearchCellSelected.onNext(())
            }
        }
    }
}
