//
//  FeedView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import SnapKit

final class FeedView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    let reviewExceptionView: ReviewExceptionView = {
        let view = ReviewExceptionView(explainText: "아직 작성된 리뷰가 없어요 \n첫 번째 리뷰를 작성해 보세요")
        view.isHidden = true
        return view
    }()
    
    let writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "write"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setHierarchy() {
        self.addSubview(collectionView)
        self.addSubview(reviewExceptionView)
        self.addSubview(writeButton)
    }
    
    override func setupLayout() {

        collectionView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(368)
        }
        
        reviewExceptionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(368)
        }
        
        writeButton.snp.makeConstraints { make in
            make.height.width.equalTo(51)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.feedLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
        
    private func feedLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .absolute(178) // Use fractionalHeight instead of fractionalWidth
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item]) // Use vertical instead of horizontal
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

extension FeedView {
    func reviewException(data: Bool) {
        reviewExceptionView.isHidden = data
    }
}
