//
//  EditProfileViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import UIKit
import RxCocoa
import RxSwift

final class EditProfileViewController: BaseViewController {
    private let selfView = EditProfileView()
    
    private let viewModel: EditProfileViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("EditProfileViewController: fatal error")
    }
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = selfView
    }
}
