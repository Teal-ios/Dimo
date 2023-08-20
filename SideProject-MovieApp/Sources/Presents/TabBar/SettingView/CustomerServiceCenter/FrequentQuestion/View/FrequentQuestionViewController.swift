//
//  FrequentQuestionViewController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/15.
//

import UIKit
import RxSwift
import RxCocoa

final class FrequentQuestionViewController: BaseViewController {
    
    struct Item: Hashable {
        private let uuid = UUID()
        let title: String
        let answer: String
    }
    
    private let frequentQuestionView = FrequentQuestionView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>!
    
    private let viewModel: FrequentQuestionViewModel
    
    private lazy var items: [Item] = {
        let items = viewModel.mockData.map { Item(title: $0.title, answer: $0.answer) }
        return items
    }()
    
    init(viewModel: FrequentQuestionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = frequentQuestionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDataSource()
        self.applySnapshot()
        self.frequentQuestionView.collectionView.delegate = self
    }
    
    override func setupBinding() {
//        let input = NoticeViewModel.Input(noticeCellSelected: self.noticeCellSelected)
//        let output = self.viewModel.transform(input: input)
//
//        output.isHiddenContents
//            .withUnretained(self)
//            .bind { (vc, isHidden) in
//
//            }
//            .disposed(by: disposeBag)
        
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<QuestionListCell, Item> { (cell, indexPath, itemIdentifier) in
            cell.configure(QuestionListCellViewModel(title: itemIdentifier.title, message: itemIdentifier.answer))
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: frequentQuestionView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
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

extension FrequentQuestionViewController: UICollectionViewDelegate {
    
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
