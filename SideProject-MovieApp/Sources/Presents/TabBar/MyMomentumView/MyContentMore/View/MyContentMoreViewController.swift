//
//  MyContentMoreViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/27.
//

import UIKit
import RxCocoa
import RxSwift

final class MyContentMoreViewController: BaseViewController {
    
    private let selfView = MyContentMoreView()
    
    private var viewModel: MyContentMoreViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("MyContentMoreViewController: fatal error")
    }
    
    init(viewModel: MyContentMoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private var likeContentDataSource: UICollectionViewDiffableDataSource<Int, LikeContent>!
    
    override func loadView() {
        view = selfView
    }
    
    let viewDidLoadToSetDataSource = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLikeContentDataSource()
        self.viewDidLoadToSetDataSource.accept(())
    }
    
    override func setupBinding() {
        let input = MyContentMoreViewModel.Input(viewDidLoadToSetDataSource: self.viewDidLoadToSetDataSource)
        let output = self.viewModel.transform(input: input)
        
        output.viewDidLoadToSetDataSource
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .flatMap { void -> BehaviorRelay<[LikeContent?]> in
                return output.likeContent
            }
            .bind { [weak self] likeContentList in
                guard let self else { return }
                var likeContentSnapshot = NSDiffableDataSourceSnapshot<Int, LikeContent>()
                likeContentSnapshot.appendSections([0])
                var sectionArr: [LikeContent] = []
                for i in likeContentList {
                    guard let i = i else { return }
                    sectionArr.append(i)
                }
                likeContentSnapshot.appendItems(sectionArr, toSection: 0)
                self.likeContentDataSource.apply(likeContentSnapshot)
            }
            .disposed(by: disposeBag)
    }
}

extension MyContentMoreViewController {
    func setLikeContentDataSource() {
        let cellLikeContentRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, LikeContent> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(likeContent: itemIdentifier)
        }
        
        likeContentDataSource = UICollectionViewDiffableDataSource(collectionView: selfView.cardCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellLikeContentRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
}
