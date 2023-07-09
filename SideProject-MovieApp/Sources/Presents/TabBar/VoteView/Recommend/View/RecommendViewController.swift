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
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
    
    let searchNavigationButtonTap = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.collectionView.delegate = self
        searchNavigationItemSet()
        setDataSource()
    }
    
    override func setupBinding() {
        let input = RecommendViewModel.Input(viewDidLoad: Observable.just(()))
        
        let output = self.viewModel.transform(input: input)
        output.animationData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] data in
                guard let self = self else { return }
                print(data.count, "data 개수")
                var snapshot = NSDiffableDataSourceSnapshot<Int, AnimationData>()
                snapshot.appendSections([0, 1])
                var section1Arr: [AnimationData] = []
                
                section1Arr.append(contentsOf: [data[0], data[1], data[2], data[3], data[4], data[5], data[11], data[12]])

                
                snapshot.appendItems(section1Arr, toSection: 0)

                self.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
    }
}

extension RecommendViewController {
    func setDataSource() {
        let cellCharacterRegistration =
        UICollectionView.CellRegistration<VoteCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
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
