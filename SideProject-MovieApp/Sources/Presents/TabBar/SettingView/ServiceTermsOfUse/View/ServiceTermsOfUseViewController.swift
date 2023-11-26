//
//  ServiceTermsOfUseViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 11/19/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ServiceTermsOfUseViewController: BaseViewController {
    private let selfView = ServiceTermsOfUseView()
    
    override func loadView() {
        self.view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.contentLabel.delegate = self
        updateTextViewAttribute(text: selfView.contentLabel.text, keywords: [
        "제1조 목적",
        "제2조 정의",
        "제3조 약관의 게시 및 개정",
        "제4조 서비스의 제공",
        "제5조 서비스 이용 시 주의점",
        "제6조 서비스의 중단",
        "제7조 회원가입",
        "제8조 회원탈퇴 및 자격상실 등",
        "제9조 회원에 대한 통지 및 홍보 내용 표시",
        "제10조 개인정보의 관리 및 보호",
        "제11조 저작권의 귀속",
        "제12조 DIMO의 의무",
        "제13조 이용자의 의무",
        "제14조 손해배상 및 면책조항",
        "제 15조 기타",
        "[부칙]"
        ])
    }
}

extension ServiceTermsOfUseViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}

extension ServiceTermsOfUseViewController {
    func updateTextViewAttribute(text: String, keywords: [String]) {
        let attributtedString = NSMutableAttributedString(string: text)
        for keyword in keywords {
            attributtedString.addAttribute(.font, value: Font.subtitle3!, range: (text as NSString).range(of: keyword))
        }

        selfView.contentLabel.attributedText = attributtedString
        selfView.contentLabel.textColor = .black5
    }
}
