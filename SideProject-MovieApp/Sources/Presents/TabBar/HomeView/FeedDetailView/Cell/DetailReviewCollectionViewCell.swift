//
//  DetailReviewCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import SnapKit
import RxSwift

protocol CommentLikeButtonTapDelegate: AnyObject {
    func commentLikeButtonTapped(_ collectionViewCell: BaseCollectionViewCell)
}

final class DetailReviewCollectionViewCell: BaseCollectionViewCell {
    
    var disposeBag = DisposeBag()
        
    static let identifier = "DetailReviewCollectionViewCell"
    
    weak var delegate: CommentLikeButtonTapDelegate?
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        return view
    }()
    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        view.backgroundColor = .black5
        view.clipsToBounds = true
        return view
    }()
    
    let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .black5
        label.textAlignment = .left
        label.text = "정대만"
        return label
    }()
    
    let mbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.textAlignment = .left
        let mbti = UserDefaultManager.mbti ?? "ISFJ"
        label.text = mbti
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black5
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "불러 계절이 하나에 하나에 까닭입니다. 멀리 시인의 이름자를 소학교 마리아 추억과 슬퍼하는 하늘에는 버리었습니다."
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "LikeSelect"), for: .normal)
        return button
    }()
    
    let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.textAlignment = .left
        label.text = "0"
        return label
    }()
    
    let feedButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let modifyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vertical_ellipsis"), for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
        bgView.layer.cornerRadius = 8
    }
        
    override func configure() {
        [bgView, imgView, characterNameLabel, mbtiLabel, reviewLabel, likeButton, likeCountLabel, feedButton, modifyButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        imgView.snp.makeConstraints { make in
            make.leading.top.equalTo(bgView).inset(16)
            make.height.width.equalTo(48)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.top)
            make.leading.equalTo(imgView.snp.trailing).offset(8)
            make.trailing.equalTo(bgView.snp.trailing)
            make.height.equalTo(24)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterNameLabel.snp.leading)
            make.top.equalTo(characterNameLabel.snp.bottom).offset(4)
            make.trailing.equalTo(bgView.snp.trailing)
            make.bottom.equalTo(imgView.snp.bottom)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(bgView).inset(16)
            make.top.equalTo(imgView.snp.bottom).offset(16)
            make.bottom.equalTo(likeButton.snp.top).offset(-16)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(bgView).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.width.equalTo(16)
        }
        
        likeCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(4)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(16)
        }
        
        feedButton.snp.makeConstraints { make in
            make.leading.top.equalTo(imgView)
            make.height.equalTo(48)
            make.width.equalTo(100)
        }
        
        modifyButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalTo(imgView)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}

extension DetailReviewCollectionViewCell {
    func configureCommentAttribute(with item: CommentList) {
        reviewLabel.text = item.comment_content
        characterNameLabel.text = item.nickname
        likeCountLabel.text = "\(item.comment_like)"
        mbtiLabel.text = item.mbti
        
        
        if item.is_liked == nil {
            self.updateLikeImage(is_like: false)
        } else {
            self.updateLikeImage(is_like: true)
        }
        
        updateModifyButton(user_id: item.user_id)
        
        guard let urlString = item.profile_img else { return }
        let newURL = "gs://dimo-b40ac.appspot.com/\(urlString)"
        FirebaseStorageManager.downloadImage(urlString: newURL) { [weak self] image in
            self?.imgView.image = image
        }
    }
}

extension DetailReviewCollectionViewCell {
    func updateLikeImage(is_like: Bool) {
        switch is_like {
        case true:
            self.likeButton.setImage(UIImage(named: "LikeSelect"), for: .normal)
        case false:
            self.likeButton.setImage(UIImage(named: "LikeNonSelect"), for: .normal)
        }
    }
}

extension DetailReviewCollectionViewCell {
    func updateModifyButton(user_id: String) {
        guard let myId = UserDefaultManager.userId else { return }
        if myId == user_id {
            self.modifyButton.isHidden = false
        } else {
            self.modifyButton.isHidden = true
        }
    }
}
