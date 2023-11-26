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
        updateTextViewAttribute(text: selfView.contentLabel.text, keywords: [
        "1. Snapkit",
        "2. Tabman",
        "3. ReactiveX",
        "4. GoogleSignIn",
        "5. KakaoOpenADK",
        "6. KingFisher",
        "7. Toast",
        "8. Lottie"
        ])
    }
}

extension OpenSourceLicenseViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}

extension OpenSourceLicenseViewController {
    func updateTextViewAttribute(text: String, keywords: [String]) {
        let attributtedString = NSMutableAttributedString(string: text)
        for keyword in keywords {
            attributtedString.addAttribute(.font, value: Font.subtitle3!, range: (text as NSString).range(of: keyword))
        }

        selfView.contentLabel.attributedText = attributtedString
        selfView.contentLabel.textColor = .black5
    }
}
