//
//  FeedDetailHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import SnapKit

class FeedDetailHeaderView: BaseView {
    static let identifier = "FeedDetailHeaderView"
    
    let profileImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "id12"
        label.textColor = .black5
        label.font = Font.body2
        return label
    }()
    
    let mbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.text = "ENTP"
        return label
    }()
    
    let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "루피가 와노쿠니 가서 카이도쿠랑 싸울 때 작화 보셨나요. 저는 진짜 보고 원피스 지금까지 잘 참고 왔다를 새삼 느꼈습니다. 너무재밌어요... 그리고 그 누구야 빅맘이랑 그 전에 편은 너무 재미없었다가 이제 진짜 본격적으로 재밌어지기 시작하는것 같네요...! 앞으로가 기대가 됩니다. 루피가 와노쿠니 가서 카이도쿠랑 싸울 때 작화 보셨나요. 저는 진짜 보고 원피스 지금까지 잘 참고 왔다를 새삼 느꼈습니다. 너무재밌어요... 그리"
        label.numberOfLines = 0
        label.font = Font.body3
        label.textColor = .black5
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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let reviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Review")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "좋아요"
        label.font = Font.body3
        label.textColor = .black60
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글달기"
        label.font = Font.body3
        label.textColor = .black60
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
    
    let likeContainButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var likeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeImageView, likeLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = -12
        return stackView
    }()
    
    lazy var reviewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewImageView, reviewLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = -12
        return stackView
    }()
    
    lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeStackView, reviewStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let spoilerCommentChoiceContainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let spoilerCommentChoiceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "NotChoice"), for: .normal)
        return button
    }()
    
    let spoilerCommentExplainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black5
        label.text = "스포일러 포함된 댓글 가리기"
        return label
    }()
    
    let otherFeedButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileImgView)
        self.addSubview(nicknameLabel)
        self.addSubview(mbtiLabel)
        self.addSubview(likeAndReviewAndViewsLabel)
        self.addSubview(totalStackView)
        self.addSubview(mainTextLabel)
        self.addSubview(likeContainButton)
        self.addSubview(lineView)
        self.addSubview(spoilerCommentChoiceContainView)
        self.addSubview(spoilerCommentChoiceButton)
        self.addSubview(spoilerCommentExplainLabel)
        self.addSubview(otherFeedButton)
        makeConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let safeArea = self.safeAreaLayoutGuide

        profileImgView.snp.makeConstraints { make in
            make.top.equalTo(safeArea)
            make.height.width.equalTo(50)
            make.leading.equalTo(safeArea)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImgView.snp.top)
            make.leading.equalTo(profileImgView.snp.trailing).offset(8)
            make.height.equalTo(24)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.leading.equalTo(profileImgView.snp.trailing).offset(8)
            make.height.equalTo(16)
        }
        
        totalStackView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.horizontalEdges.equalTo(safeArea).inset(32)
        }
        
        likeAndReviewAndViewsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(totalStackView.snp.top).offset(0)
            make.horizontalEdges.equalTo(safeArea)
            make.height.equalTo(16)
        }
        
        mainTextLabel.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeArea)
            make.bottom.equalTo(likeAndReviewAndViewsLabel.snp.top).offset(-16)
        }
        
        likeContainButton.snp.makeConstraints { make in
            make.leading.equalTo(totalStackView.snp.leading)
            make.width.equalTo(totalStackView.snp.width).multipliedBy(0.5)
            make.verticalEdges.equalTo(totalStackView)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(totalStackView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        spoilerCommentChoiceContainView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(36)
            make.bottom.equalTo(safeArea).offset(-16)
        }
        
        spoilerCommentChoiceButton.snp.makeConstraints { make in
            make.leading.equalTo(spoilerCommentChoiceContainView.snp.leading)
            make.centerY.equalTo(spoilerCommentChoiceContainView)
            make.height.width.equalTo(24)
        }
        
        spoilerCommentExplainLabel.snp.makeConstraints { make in
            make.leading.equalTo(spoilerCommentChoiceButton.snp.trailing).offset(8)
            make.centerY.equalTo(spoilerCommentChoiceContainView)
            make.trailing.equalTo(spoilerCommentChoiceContainView)
            make.height.equalTo(21)
            
        }
        
        otherFeedButton.snp.makeConstraints { make in
            make.top.leading.equalTo(profileImgView)
            make.bottom.trailing.equalTo(mbtiLabel)
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

extension FeedDetailHeaderView {
    func configureFeedDetailHeaderView(with item: ReviewList) {
        print(item, "들어오는 리뷰")
        mainTextLabel.text = item.review_content
        nicknameLabel.text = item.nickname
        mbtiLabel.text = item.mbti
        self.updateProfileImage(with: item.profile_img)
        let  commentCnt = item.comment_count ?? 0
        likeAndReviewAndViewsLabel.text = "좋아요 \(item.review_like)  |  댓글 \(commentCnt)  |  조회 \(item.review_hits)"
    }
    
    func updateProfileImage(with url: String?) {
        guard let url else { return }
        guard let imageURL = URL(string: url) else { return }
        profileImgView.kf.setImage(with: imageURL)
    }
}

extension FeedDetailHeaderView {
    func spoilerIsOn() {
        spoilerCommentChoiceContainView.isHidden = true
        spoilerCommentChoiceButton.isHidden = true
        spoilerCommentExplainLabel.isHidden = true
        
        spoilerCommentChoiceContainView.snp.updateConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(1)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(0)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
        }
    }
}
