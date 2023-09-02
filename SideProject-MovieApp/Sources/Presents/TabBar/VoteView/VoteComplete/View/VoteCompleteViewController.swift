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
    let rightNavigationXButtonTapped = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationAttribute()
        self.setCharacterDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func setupBinding() {
        let input = VoteCompleteViewModel.Input(viewDidLoad: self.viewDidLoadTrigger, rightNavigationXButtonTapped: self.rightNavigationXButtonTapped, characterSelectButtonTapped: self.selfView.characterSelectButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.sameWorkAnotherCharacterList
            .withUnretained(self)
            .bind { vc, sameWorkCharacter in
                if sameWorkCharacter.result != [] {
                    var characterSnapshot = NSDiffableDataSourceSnapshot<Int, Result>()
                    characterSnapshot.appendSections([0])
                    var characterArr: [Result] = []
                    for i in 0...2 {
                        guard let character = sameWorkCharacter.result[i] else { return }
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
        
//        output.voteCharacter
//            .observe(on: MainScheduler.instance)
//            .withUnretained(self)
//            .bind { vc, voteCharacter in
////                vc.selfView.configureUpdateVoteCharacter(with: voteCharacter)
//            }
//            .disposed(by: disposeBag)
        
        output.inquireVoteResult
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, voteResult in
                vc.selfView.configureUpdateChart(with: voteResult)
                vc.selfView.configureUpdateMbtiContent(with: voteResult)
            }
            .disposed(by: disposeBag)
    }
}

extension VoteCompleteViewController {
    private func setCharacterDataSource() {
        let cellCharacterRegistration = UICollectionView.CellRegistration<DigFinishCharacterCollectionViewCell, Result> { cell, indexPath, itemIdentifier in
            cell.configureUIToResultData(with: itemIdentifier)
            cell.configureIsVoted(vote: itemIdentifier.is_vote ?? 0)
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

extension VoteCompleteViewController {
    func setNavigationAttribute() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "Icon_close"), style: .plain, target: self, action: #selector(xButtonTapped))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
}

extension VoteCompleteViewController {
    @objc
    func xButtonTapped() {
        self.rightNavigationXButtonTapped.accept(())
    }
}
