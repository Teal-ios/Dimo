//
//  VoteCompleteViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/05.
//


import UIKit
import RxSwift
import RxCocoa

final class VoteCompleteViewController: BaseViewController {
    
    let selfView = VoteCompleteView()
    
    private var viewModel: VoteCompleteViewModel
    
    init(viewModel: VoteCompleteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private var characterDataSource: UICollectionViewDiffableDataSource<Int, Result>!

    
    override func loadView() {
        view = selfView
    }
    
    let viewDidLoadTrigger = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCharacterDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func setupBinding() {
        let input = VoteCompleteViewModel.Input(viewDidLoad: self.viewDidLoadTrigger)
        let output = viewModel.transform(input: input)
        
        output.sameWorkAnotherCharacterList
            .withUnretained(self)
            .bind { vc, sameWorkCharacter in
                if sameWorkCharacter.result != [] {
                    var characterSnapshot = NSDiffableDataSourceSnapshot<Int, Result>()
                    characterSnapshot.appendSections([0])
                    var characterArr: [Result] = []
                    for character in sameWorkCharacter.result {
                        guard let character else { return }
                        characterArr.append(character)
                    }
                    characterSnapshot.appendItems(characterArr, toSection: 0)
                    vc.characterDataSource.apply(characterSnapshot)
                }
            }
            .disposed(by: disposeBag)
        
        output.characterInfo
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, characterInfo in
                vc.selfView.configureUpdateCharacterInfo(with: characterInfo)
            }
            .disposed(by: disposeBag)
    }
}

extension VoteCompleteViewController {
    private func setCharacterDataSource() {
        let cellCharacterRegistration = UICollectionView.CellRegistration<DigFinishCharacterCollectionViewCell, Result> { cell, indexPath, itemIdentifier in
            cell.configureUIToResultData(with: itemIdentifier)
        }
        
        characterDataSource = UICollectionViewDiffableDataSource(collectionView: selfView.characterMoreCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        characterDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            header.titleLabel.text = "같은 작품 속 캐릭터 투표하기"
            return header
        })
    }
}
