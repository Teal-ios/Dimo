//
//  FeedDetailHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import SnapKit

class FeedDetailHeaderView: UICollectionReusableView {
    static let identifier = "FeedDetailHeaderView"
    
    let categoryCollectionView: DynamicCollectionView = {
        let view = DynamicCollectionView(frame: CGRect.zero, collectionViewLayout: createLayout())
       return view
    }()
    
    let profileImgView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let mbtiLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let likeAndReviewAndViewsLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.text = "좋아요 12 | 댓글 2 | 조회 100"
        return label
    }()
    
    let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LikeSelect")
        return imageView
    }()

    let reviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Review")
        return imageView
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "좋아요"
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글달기"
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let reviewButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var likeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeImageView, likeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var reviewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewImageView, reviewLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeStackView, reviewStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(categoryCollectionView)
        self.addSubview(profileImgView)
        self.addSubview(nicknameLabel)
        self.addSubview(mbtiLabel)
        self.addSubview(likeAndReviewAndViewsLabel)
        self.addSubview(totalStackView)
        self.addSubview(mainTextLabel)
        
        makeConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeArea)
            make.horizontalEdges.equalTo(safeArea).inset(16)
            make.height.greaterThanOrEqualTo(48)
        }
        profileImgView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            make.height.width.equalTo(50)
            make.leading.equalTo(16)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImgView.snp.top)
            make.leading.equalTo(profileImgView.snp.trailing).offset(8)
            make.height.equalTo(24)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImgView.snp.top)
            make.leading.equalTo(profileImgView.snp.trailing).offset(8)
            make.height.equalTo(16)
        }
        
        totalStackView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.horizontalEdges.bottom.equalTo(safeArea)
        }
        
        likeAndReviewAndViewsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(mbtiLabel.snp.top).offset(-16)
            make.horizontalEdges.equalTo(16)
            make.height.equalTo(16)
        }
        
        mainTextLabel.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeArea).inset(16)
            make.bottom.equalTo(likeAndReviewAndViewsLabel.snp.bottom)
        }
    }
}

extension FeedDetailHeaderView {
    private static func createLayout() -> UICollectionViewCompositionalLayout {
            //item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(200),
                heightDimension: .absolute(32)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(32)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.interItemSpacing = .fixed(8)
            //sections
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
            //return
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .vertical
            
            let layout = UICollectionViewCompositionalLayout(section: section)
            layout.configuration = config
            
            return layout
        }
}
