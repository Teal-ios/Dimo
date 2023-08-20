//
//  NoticeView.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/13.
//

import UIKit

final class NoticeView: BaseView {
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항"
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func setHierarchy() {
        containerView.addSubview(titleLabel)
        self.addSubview(containerView)
        self.addSubview(collectionView)
    }
    
    override func setupLayout() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.height.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading)
            make.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension NoticeView {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize.init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(72.0)
        )

        let section = NSCollectionLayoutSection(group:
            .vertical(layoutSize: layoutSize,
                      subitems: [.init(layoutSize: layoutSize)])
        )
        
        section.contentInsets = .init(top: 36, leading: 4, bottom: 16, trailing: 4)
        section.interGroupSpacing = 0

        return UICollectionViewCompositionalLayout(section: section)
    }
}
