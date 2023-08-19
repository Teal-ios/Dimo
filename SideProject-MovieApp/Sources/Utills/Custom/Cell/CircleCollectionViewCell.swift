//
//  CircleCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import SnapKit

class CircleCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "CircleCollectionViewCell"

    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        view.backgroundColor = .black5
        view.clipsToBounds = true
        return view
    }()
    
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.clipsToBounds = true
        view.alpha = 0.98
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
        blurView.layer.cornerRadius = blurView.frame.width / 2
    }
        
    override func configure() {
        [imgView, blurView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        imgView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(imgView.snp.width)
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalTo(imgView)
        }
    }
}

extension CircleCollectionViewCell {
    func configureAttribute(with item: Character) {
        guard let data = Data(base64Encoded: item.characterImg, options: .ignoreUnknownCharacters)
        else { return }
        print(data, "인코딩된 이미지")
        guard let image = UIImage(data: data) else { return }
        imgView.image = image
        imgView.contentMode = .scaleToFill
    }
}

extension CircleCollectionViewCell {
    func configureAttributeToSameMbtiCharacter(with item: SameMbtiCharacter) {
        let imageURL = URL(string: item.character_img ?? "")
        imgView.kf.setImage(with: imageURL)
        imgView.contentMode = .scaleToFill
    }
}
