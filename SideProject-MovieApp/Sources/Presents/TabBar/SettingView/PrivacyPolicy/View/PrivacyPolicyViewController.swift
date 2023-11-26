//
//  PrivacyPolicyViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 11/19/23.
//

import UIKit
import RxSwift
import RxCocoa

final class PrivacyPolicyViewController: BaseViewController {
    private let selfView = PrivacyPolicyView()
    
    override func loadView() {
        self.view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.contentLabel.delegate = self
        updateTextViewAttribute(text: selfView.contentLabel.text, keywords:
        [
            "제1조(개인정보의 처리 목적)",
            "제2조(개인정보의 처리 및 보유 기간)",
            "제3조(만 14세 미만 아동의 개인정보 처리에 관한 사항)",
            "제4조(개인정보의 제3자 제공에 관한 사항)",
            "제5조(개인정보처리의 위탁에 관한 사항)",
            "제6조(개인정보의 파기절차 및 파기방법)",
            "제7조(휴면 회원의 개인정보 파기 등에 관한 조치)",
            "제8조(정보주체와 법정대리인의 권리·의무 및 그 행사방법에 관한 사항)",
            "제9조(개인정보의 안전성 확보 조치에 관한 사항)",
            "제10조(개인정보를 자동으로 수집하는 장치의 설치·운영 및 거부 방법)",
            "제11조(추가적인 이용·제공 판단 기준)",
            "제12조 (회원의 권리와 의무)",
            "제13조 (고지의 의무)",
            "제14조 (개인정보 처리 업무)",
            "제15조(개인정보의 열람 및 정정)",
            "제16조(개인정보 처리방침 변경)"
        ]
        )
    }
}

extension PrivacyPolicyViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}

extension PrivacyPolicyViewController {
    func updateTextViewAttribute(text: String, keywords: [String]) {
        let attributtedString = NSMutableAttributedString(string: text)
        for keyword in keywords {
            attributtedString.addAttribute(.font, value: Font.subtitle3!, range: (text as NSString).range(of: keyword))
        }

        selfView.contentLabel.attributedText = attributtedString
        selfView.contentLabel.textColor = .black5
    }
}
