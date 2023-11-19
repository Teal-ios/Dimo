//
//  OpenSourceLicenseViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 11/19/23.
//

import UIKit
import RxSwift
import RxCocoa

final class OpenSourceLicenseViewController: BaseViewController {
    private let selfView = OpenSourceLicenseView()
    
    override func loadView() {
        self.view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.contentLabel.delegate = self
    }
}

extension OpenSourceLicenseViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}
