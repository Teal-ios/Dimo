//
//  MainView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import UIKit

class InitialViewController: BaseViewController {
    
    let initialView = InitialView()

    //MARK: Delegate
    weak var coordinator: InitialCoordinator?
    
    override func loadView() {
        view = initialView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")
    }
}
