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
    
    var dataSource: UICollectionViewDiffableDataSource<Int, CharacterInfo>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, CharacterInfo>()
    
    let characterRandomRecommandCellSelected = PublishSubject<Void>()
    let characterSearchCellSelected = PublishSubject<Void>()
    let viewDidLoadTrigger = PublishRelay<Void>()
    let characterCellTapped = PublishRelay<CharacterInfo>()
    let characterMoreButtonCellSelect = PublishRelay<Void>()
    let viewWillAppearTrigger = PublishRelay<Void>()
    
    
    override func loadView() {
        view = voteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.voteView.collectionView.delegate = self
        setDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearTrigger.accept(())
    }
    
    override func setupBinding() {
        let input = VoteViewModel.Input(characterRandomRecommandCellTapped: self.characterRandomRecommandCellSelected, characterSearchCellTapped: self.characterSearchCellSelected, viewDidLoad: self.viewDidLoadTrigger, characterCellTapped: self.characterCellTapped, characterMoreButtonCellTapped: self.characterMoreButtonCellSelect, viewWillAppear: self.viewWillAppearTrigger)
        
        let output = viewModel.transform(input: input)
        
        output.popularCharacterRecommend
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vc, popularCharacterRecommendData in
                var snapshot = NSDiffableDataSourceSnapshot<Int, CharacterInfo>()
                snapshot.appendSections([0, 1, 2])
                var section1Arr: [CharacterInfo] = []
                var section2Arr: [CharacterInfo] = []
                var section3Arr: [CharacterInfo] = []

                section1Arr.append(CharacterInfo(character_id: 0, content_id: 0, anime_id: nil, character_img: "CharacterRandom", character_name: "", character_mbti: nil, title: nil, is_vote: 0))
                section1Arr.append(CharacterInfo(character_id: 0, content_id: 0, anime_id: nil, character_img: "CharacterSearchNew", character_name: "", character_mbti: nil, title: nil, is_vote: 0))
                for i in 0...9 {
                    section2Arr.append(popularCharacterRecommendData.character_info[i])
                }
                section3Arr.append(CharacterInfo(character_id: 0, content_id: 0, anime_id: nil, character_img: "footer", character_name: "", character_mbti: nil, title: nil, is_vote: 0))
                snapshot.appendItems(section1Arr, toSection: 0)
                snapshot.appendItems(section2Arr, toSection: 1)
                snapshot.appendItems(section3Arr, toSection: 2)
                vc.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
        
    }
}

extension VoteViewController {
    private func setDataSource() {
        let cellCharacterRegistration = UICollectionView.CellRegistration<CharacterRecommandAndSearchCollectionViewCell, CharacterInfo> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        let cellVoteRegistration = UICollectionView.CellRegistration<VoteCollectionViewCell, CharacterInfo> { cell, indexPath, itemIdentifier in
            cell.configureAttributeWithCharacterInfo(with: itemIdentifier)
            cell.configureIsVoted(vote: itemIdentifier.is_vote ?? 0)
        }
        
        let cellFooterRegistration = UICollectionView.CellRegistration<VoteFooterCell, CharacterInfo> {cell, indexPath, itemIdentifier in
        }
            
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: voteView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellCharacterRegistration, for: indexPath, item: itemIdentifier)
                return cell
            case 2:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellFooterRegistration, for: indexPath, item: itemIdentifier)
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
            case 2:
                return nil
            default:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: voteHeader, for: indexPath)
                return header

            }
        })
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
        } else if indexPath.section == 1 {
            self.dataFetchingToCharacterCell(indexPath: indexPath)
        } else {
            self.characterMoreButtonCellSelect.accept(())
        }
    }
}

extension VoteViewController {
    func dataFetchingToCharacterCell(indexPath: IndexPath) {
        let selectedItem = dataSource.snapshot().itemIdentifiers(inSection: 1)[indexPath.row]
        self.characterCellTapped.accept(selectedItem)
    }
}
