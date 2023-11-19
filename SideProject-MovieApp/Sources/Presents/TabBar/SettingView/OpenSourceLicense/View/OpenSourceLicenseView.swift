//
//  OpenSourceLicenseView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 11/19/23.
//

import UIKit
import SnapKit

final class OpenSourceLicenseView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.title1
        label.text = "오픈소스 라이선스"
        return label
    }()
    

    let contentLabel: UITextView = {
        let label = UITextView()
        label.textColor = .black5
        label.font = Font.body3
        label.dataDetectorTypes = .link
        label.isEditable = false
        label.text =
        """
이 문서는 다음 오픈소스 프로젝트의 라이선스 정보를 제공합니다.

## **1. Snapkit**

- GitHub 링크: [SnapKit GitHub](https://github.com/SnapKit/SnapKit)
- 라이선스: MIT 라이선스

SnapKit 프로젝트는 MIT 라이선스 하에 배포됩니다. MIT 라이선스에 따라, 이 소프트웨어를 사용, 복제, 수정, 병합, 게시, 배포, 하위 라이선스 부여 등을 포함한 모든 작업을 자유롭게 수행할 수 있습니다. 자세한 정보는 [MIT 라이선스 전문](https://github.com/SnapKit/SnapKit/blob/main/LICENSE)을 참조하십시오.

## **2. Tabman**

- GitHub 링크: [Tabman GitHub](https://github.com/uias/Tabman)
- 라이선스: MIT 라이선스

Tabman 프로젝트도 MIT 라이선스 하에 배포됩니다. MIT 라이선스의 자세한 내용은 [MIT 라이선스 전문](https://github.com/uias/Tabman/blob/master/LICENSE)을 확인하십시오.

## **3. ReactiveX**

- GitHub 링크: [ReactiveX GitHub](https://github.com/ReactiveX/RxSwift)
- 라이선스: Apache License 2.0

ReactiveX (RxSwift) 프로젝트는 Apache License 2.0 하에 배포됩니다. Apache License 2.0은 상업적인 이용을 포함한 여러 가지 용도로 소프트웨어를 사용할 수 있는 자유로운 라이선스입니다. 자세한 내용은 [Apache License 2.0 전문](https://github.com/ReactiveX/RxSwift/blob/main/LICENSE)을 확인하십시오.

## **4. GoogleSignIn**

- 문서 링크: [Google Sign-In for iOS](https://firebase.google.com/docs/auth/ios/google-signin?hl=ko)
- 라이선스: Firebase Terms of Service

GoogleSignIn은 Firebase에서 제공하는 서비스 중 하나로, Firebase의 이용 약관에 따라 사용됩니다. Firebase의 이용 약관은 Firebase 웹 사이트에서 확인하실 수 있습니다.

## **5. KakaoOpenADK**

- GitHub 링크: [KakaoOpenADK GitHub](https://github.com/kakao/kakao-ios-sdk)
- 라이선스: Apache License 2.0

KakaoOpenADK 프로젝트는 Apache License 2.0 하에 배포됩니다. Apache License 2.0의 자세한 내용은 [Apache License 2.0 전문](https://github.com/kakao/kakao-ios-sdk/blob/master/LICENSE)을 확인하십시오.

## **6. KingFisher**

- GitHub 링크: [KingFisher GitHub](https://github.com/onevcat/Kingfisher)
- 라이선스: MIT 라이선스

KingFisher 프로젝트는 MIT 라이선스 하에 배포됩니다. MIT 라이선스에 대한 자세한 내용은 [MIT 라이선스 전문](https://github.com/onevcat/Kingfisher/blob/master/LICENSE)을 참조하십시오.

## **7. Toast**

- GitHub 링크: [Toast GitHub](https://github.com/scalessec/Toast-Swift)
- 라이선스: MIT 라이선스

Toast 프로젝트는 MIT 라이선스 하에 배포됩니다. MIT 라이선스에 대한 자세한 내용은 [MIT 라이선스 전문](https://github.com/scalessec/Toast-Swift/blob/master/LICENSE)을 확인하십시오.

## **8. Lottie**

- GitHub 링크: [Lottie GitHub](https://github.com/airbnb/lottie-ios)
- 라이선스: Apache License 2.0

Lottie 프로젝트는 Apache License 2.0 하에 배포됩니다. Apache License 2.0의 자세한 내용은 [Apache License 2.0 전문](https://github.com/airbnb/lottie-ios/blob/master/LICENSE)을 참조하십시오.
"""
        return label
    }()
    
    override func setHierarchy() {
        super.setHierarchy()
        addSubview(titleLabel)
        addSubview(contentLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(72)
            make.height.equalTo(29)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(44)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)

        }
    }
}
