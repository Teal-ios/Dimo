//
//  DeleteCommentAlertView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/21.
//

import UIKit
import SnapKit

final class DeleteCommentAlertView: BaseView {
    let alertView: AlertButtonSecondView = {
        let view = AlertButtonSecondView(title: "댓글 삭제", subtitle: "정말 삭제하시겠습니까?", okButtonTitle: "아니요", cancelButtonTitle: "삭제")
        return view
    }()
    
    override func setHierarchy() {
        self.addSubview(alertView)
    }
    
    override func setupLayout() {
        
        alertView.basePopupView.snp.removeConstraints()
        alertView.titleLabel.snp.removeConstraints()
        alertView.okButtonLabel.snp.removeConstraints()
        alertView.okButton.snp.removeConstraints()
        alertView.cancelButtonLabel.snp.removeConstraints()
        alertView.cancelButton.snp.removeConstraints()
        alertView.basePopupView.snp.remakeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(166)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        alertView.titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(alertView.basePopupView.snp.top).inset(42)
            make.height.equalTo(19)
            make.leading.trailing.equalTo(alertView.basePopupView)
        }
        
        alertView.subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(alertView.titleLabel.snp.bottom).offset(4)
            make.height.equalTo(21)
            make.leading.trailing.equalTo(alertView.basePopupView)
        }
        
        alertView.okButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(alertView.subtitleLabel.snp.bottom).offset(24)
            make.width.equalTo(alertView.basePopupView.snp.width).multipliedBy(0.5)
            make.leading.bottom.equalTo(alertView.basePopupView)
        }
        
        alertView.cancelButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(alertView.subtitleLabel.snp.bottom).offset(24)
            make.width.equalTo(alertView.basePopupView.snp.width).multipliedBy(0.5)
            make.trailing.bottom.equalTo(alertView.basePopupView)
        }
        
        alertView.okButton.snp.remakeConstraints { make in
            make.edges.equalTo(alertView.okButtonLabel)
        }
        
        alertView.cancelButton.snp.remakeConstraints { make in
            make.edges.equalTo(alertView.cancelButtonLabel)
        }
        
        alertView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        alertView.backgroundColor = .clear
    }
}
