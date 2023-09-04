//
//  MyCommentMoreViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa

final class MyCommentMoreViewController: BaseViewController {
    let selfView = MyCommentMoreView()
    
    private let viewModel: MyCommentMoreViewModel
    
    init(viewModel: MyCommentMoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, MyComment>!
    
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
        let input = MyCommentMoreViewModel.Input()
        
        let output = self.viewModel.transform(input: input)
        
        Observable
            .zip(output.myComment, self.viewDidLoadTrigger)
            .bind { [weak self] comment, _ in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Int, MyComment>()
                snapshot.appendSections([0])
                var commentArr: [MyComment] = []
                for ele in comment {
                    guard let ele = ele else { return }
                    commentArr.append(ele)
                }
                snapshot.appendItems(commentArr, toSection: 0)
                self.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
    }
}

extension MyCommentMoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCellSelected.accept(())
    }
}

extension MyCommentMoreViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ReviewCollectionViewCell, MyComment> { cell, indexPath, itemIdentifier in
            cell.configureUpdateCommentDate(comment: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
        })
    }
}
