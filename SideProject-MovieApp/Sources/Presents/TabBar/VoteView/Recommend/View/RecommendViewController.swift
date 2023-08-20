//
//  RecommendViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/09.
//

import UIKit
import RxSwift
import RxCocoa

final class RecommendViewController: BaseViewController {
    let selfView = RecommendView()
    
    private var viewModel: RecommendViewModel
    
    override func loadView() {
        view = selfView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("RecommendViewController: fatal error")
        
    }
    
    init(viewModel: RecommendViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, CharacterInfo>!
    
    let searchNavigationButtonTap = PublishSubject<Void>()
    let viewDidLoadTrigger = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.collectionView.delegate = self
        searchNavigationItemSet()
        setDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func setupBinding() {
        let input = RecommendViewModel.Input(viewDidLoad: self.viewDidLoadTrigger, randomButtonTap: self.selfView.categoryContainView.animationButton.rx.tap, popularButtonTap: self.selfView.categoryContainView.movieButton.rx.tap, categoryButtonTap: self.selfView.categoryButton.rx.tap)
        
        let output = self.viewModel.transform(input: input)
        output.randomCharacterRecommend
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vc, randomCharacterRecommend in
                var snapshot = NSDiffableDataSourceSnapshot<Int, CharacterInfo>()
                snapshot.appendSections([0])
                var sectionArr: [CharacterInfo] = []
                for i in randomCharacterRecommend.character_info {
                    sectionArr.append(i)
                }
                snapshot.appendItems(sectionArr, toSection: 0)
                vc.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
        
        output.popularCharacterRecommend
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vc, popularCharacterRecommend in
                var snapshot = NSDiffableDataSourceSnapshot<Int, CharacterInfo>()
                snapshot.appendSections([0])
                var sectionArr: [CharacterInfo] = []
                for i in popularCharacterRecommend.character_info {
                    sectionArr.append(i)
                }
                snapshot.appendItems(sectionArr, toSection: 0)
                vc.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
        
        output.categoryButtonTap
            .withUnretained(self)
            .bind { vc, _ in
                vc.selfView.appearCategory(appear: true)
            }
            .disposed(by: disposeBag)
        
        output.popularButtonTap
            .withUnretained(self)
            .bind { vc, _ in
                vc.selfView.appearCategory(appear: false)
                vc.selfView.updateCategory(popularCategoryChoice: true)
            }
            .disposed(by: disposeBag)
        
        output.randomButtonTap
            .withUnretained(self)
            .bind { vc, _ in
                vc.selfView.appearCategory(appear: false)
                vc.selfView.updateCategory(popularCategoryChoice: false)
            }
            .disposed(by: disposeBag)
    }
}

extension RecommendViewController {
    func setDataSource() {
        let cellCharacterRegistration =
        UICollectionView.CellRegistration<VoteCollectionViewCell, CharacterInfo> { cell, indexPath, itemIdentifier in
            cell.configureAttributeWithCharacterInfo(with: itemIdentifier)
            cell.configureIsVoted(vote: itemIdentifier.is_vote)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            

                let cell = collectionView.dequeueConfiguredReusableCell(using: cellCharacterRegistration, for: indexPath, item: itemIdentifier)
                return cell

            
        }
    }
}


extension RecommendViewController: UICollectionViewDelegate {
    
}

extension RecommendViewController {
    private func searchNavigationItemSet() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .plain, target: self, action: #selector(searchButtonClicked))
        self.navigationItem.rightBarButtonItem?.tintColor = .black60

    }
    
    @objc
    func searchButtonClicked() {
        self.searchNavigationButtonTap.onNext(())
    }
}
