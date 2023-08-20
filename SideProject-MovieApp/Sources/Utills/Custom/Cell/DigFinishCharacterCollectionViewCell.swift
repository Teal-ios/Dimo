//
//  DigFinishCharacterCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/03.
//

import UIKit
import SnapKit

class DigFinishCharacterCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "DigFinishCharacterCollectionViewCell"

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
        label.textAlignment = .center
        label.text = "정대만"
        return label
    }()
    
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.clipsToBounds = true
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    
    let checkImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Check")
        view.tintColor = .black5
        view.contentMode = .scaleToFill
        view.isHidden = true
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
        blurView.layer.cornerRadius = blurView.frame.width / 2

    }
        
    override func configure() {
        [imgView, characterNameLabel].forEach { self.addSubview($0) }
        addSubview(blurView)
        addSubview(checkImageView)
    }
    
    override func setConstraints() {
        imgView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(imgView.snp.width)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(imgView)
            make.height.equalTo(24)
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalTo(imgView)
        }
        
        checkImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(imgView)
            make.width.height.equalTo(52)
        }
    }
}

extension DigFinishCharacterCollectionViewCell {
    func configureUIToResultData(with item: Result) {
        let imageURL = URL(string: item.character_img)
        imgView.kf.setImage(with: imageURL)
        imgView.contentMode = .scaleToFill
        characterNameLabel.text = item.character_name
    }
}

extension DigFinishCharacterCollectionViewCell {
    func configureUIToVotedCharacterData(with item: MyVotedCharacter) {
        let imageURL = URL(string: item.character_img)
        imgView.kf.setImage(with: imageURL)
        imgView.contentMode = .scaleToFill
        characterNameLabel.text = item.character_name
    }
}

extension DigFinishCharacterCollectionViewCell {
    func configureIsVoted(vote: Int) {
        if vote == 1 {
            self.blurView.isHidden = false
            self.checkImageView.isHidden = false
        } else {
            self.blurView.isHidden = true
            self.checkImageView.isHidden = true
        }
    }
}
