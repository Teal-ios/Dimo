//
//  IamTheCharacterDetailView.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/23.
//

import UIKit
import SnapKit

class IamTheCharacterDetailView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupLayout() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let one: CGFloat = 1.0
        let ratio: CGFloat = one / 4

        return UICollectionViewCompositionalLayout { section, env in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(ratio),
                heightDimension: .fractionalHeight(one)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(one),
                heightDimension: .fractionalHeight(ratio)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
          
            return section
        }
    }
}
