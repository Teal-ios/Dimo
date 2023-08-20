//
//  NoticeViewController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/13.
//

import UIKit
import RxSwift
import RxCocoa

final class NoticeViewController: BaseViewController {
    
    struct Item: Hashable {
        private let uuid = UUID()
        let title: String
        let subTitle: String
        let noticeMessage: String
        var isExpanded: Bool = false
    }
    
    private let noticeView = NoticeView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>!
    
    private let viewModel: NoticeViewModel
    
    let noticeCellSelected = PublishRelay<NoticeContents>()
    
    private lazy var items: [Item] = {
        let items = viewModel.mockData.map { Item(title: $0.title, subTitle: $0.date, noticeMessage: $0.message) }
        return items
    }()
    
    init(viewModel: NoticeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = noticeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDataSource()
        self.applySnapshot()
        self.noticeView.collectionView.delegate = self
    }
    
    override func setupBinding() {
        let input = NoticeViewModel.Input(noticeCellSelected: self.noticeCellSelected)
        let output = self.viewModel.transform(input: input)
        
        output.isHiddenContents
            .withUnretained(self)
            .bind { (vc, isHidden) in
                
            }
            .disposed(by: disposeBag)
        
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<NoticeListCell, Item> { (cell, indexPath, itemIdentifier) in
            cell.configure(NoticeListCellViewModel(title: itemIdentifier.title,
                                                       subTitle: itemIdentifier.subTitle,
                                                       message: itemIdentifier.noticeMessage))
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: noticeView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension NoticeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        dataSource.refresh()
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        dataSource.refresh()
        return false
    }
}
