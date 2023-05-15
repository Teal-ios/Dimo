//
//  DynamicCollectionView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit

class DynamicCollectionView: UICollectionView {
    override var intrinsicContentSize: CGSize {
      return self.contentSize
    }

    override var contentSize: CGSize {
      didSet {
          self.invalidateIntrinsicContentSize()
      }
    }
}
