//
//  ContentMoreViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import RxSwift
import RxCocoa

final class ContentMoreViewController: BaseViewController {
    let contentMoreView = ContentMoreView()
    
    private let viewModel: ContentMoreViewModel
    
    init(viewModel: ContentMoreViewModel, title: String) {
        self.viewModel = viewModel
        self.contentMoreView.titleLabel.text = title
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Hit>!
    
    let cardCellSelected = PublishSubject<Void>()
    let viewDidLoadTrigger = PublishRelay<Void>()

    override func loadView() {
        view = contentMoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentMoreView.collectionView.delegate = self
        setDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func setupBinding() {
        let input = ContentMoreViewModel.Input(viewDidLoad: self.viewDidLoadTrigger)
        
        let output = self.viewModel.transform(input: input)
        
        Observable
            .zip(output.contentData, self.viewDidLoadTrigger)
            .bind { [weak self] content, _ in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Int, Hit>()
                snapshot.appendSections([0])
                var contentArr: [Hit] = []
                for ele in content {
                    contentArr.append(ele)
                }
                snapshot.appendItems(contentArr, toSection: 0)
                self.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
    }
}

extension ContentMoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCellSelected.onNext(())
    }
}

extension ContentMoreViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, Hit> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(hit: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: contentMoreView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
