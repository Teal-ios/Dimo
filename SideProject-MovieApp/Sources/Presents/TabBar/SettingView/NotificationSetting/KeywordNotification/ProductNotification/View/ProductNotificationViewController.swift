//
//  KeywordNotificationViewController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/02.
//

import UIKit
import RxSwift
import RxCocoa

final class ProductNotificationViewController: BaseViewController {
    
    let keywordNotificationView = ProductNotificationView()
    let viewModel: ProductNotificationViewModel
    
    init(viewModel: ProductNotificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = keywordNotificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

