//
//  DiffableDataSource+Extension.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/15.
//

import UIKit

extension UICollectionViewDiffableDataSource {
    /// Reapplies the current snapshot to the data source, animating the differences.
    /// - Parameters:
    ///   - completion: A closure to be called on completion of reapplying the snapshot.
    func refresh(completion: (() -> Void)? = nil) {
        self.apply(self.snapshot(), animatingDifferences: true, completion: completion)
    }
}
