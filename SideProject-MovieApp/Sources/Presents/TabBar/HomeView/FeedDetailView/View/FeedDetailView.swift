//
//  FeedDetailView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import SnapKit

final class FeedDetailView: BaseView {
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout())
    
    lazy var containScrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(headerView)
        view.addSubview(collectionView)
        return view
    }()
        
    let headerView: FeedDetailHeaderView = {
        let view = FeedDetailHeaderView()
        return view
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    let commentTotalView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let commentContainView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .black90
        return view
    }()
    
    let spoilerButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let spoilerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black80.cgColor
        return view
    }()
    
    let spoilerCheckImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "spoilerCheckOff")
        return view
    }()
    
    let spoilerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textAlignment = .center
        label.textColor = .black60
        label.text = "스포"
        return label
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let registrationView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .black100
        return view
    }()
    
    let registrationLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textAlignment = .center
        label.text = "등록"
        label.textColor = .black80
        return label
    }()
    
    let commentTextField: UITextField = {
        let tf = UITextField()
        tf.font = Font.body2
        tf.textColor = Color.caption
        tf.placeholder = "댓글을 남겨 보세요"
        return tf
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setHierarchy() {

        self.addSubview(categoryCollectionView)
        self.addSubview(containScrollView)
        self.addSubview(commentTotalView)
        self.addSubview(commentContainView)
        self.addSubview(spoilerView)
        self.addSubview(spoilerCheckImageView)
        self.addSubview(spoilerLabel)
        self.addSubview(spoilerButton)
        self.addSubview(registrationView)
        self.addSubview(registrationLabel)
        self.addSubview(registrationButton)
        self.addSubview(commentTextField)
        self.addSubview(lineView)
    }
    
    override func setupAttributes() {
        self.collectionView.isScrollEnabled = false
    }
    
    override func setupLayout() {
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        containScrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(categoryCollectionView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-84)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(containScrollView.snp.top)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.lessThanOrEqualTo(500)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(3000)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
        
        commentTotalView.snp.makeConstraints { make in
            make.height.equalTo(84)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        commentContainView.snp.makeConstraints { make in
            make.edges.equalTo(commentTotalView).inset(16)
        }
        
        spoilerView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(commentContainView).inset(8)
            make.width.equalTo(52)
        }
        
        spoilerCheckImageView.snp.makeConstraints { make in
            make.leading.equalTo(spoilerView.snp.leading).offset(4)
            make.width.height.equalTo(16)
            make.centerY.equalTo(spoilerView)
        }
        
        spoilerLabel.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalTo(spoilerView).inset(4)
            make.leading.equalTo(spoilerCheckImageView.snp.trailing).offset(2)
        }
        
        spoilerButton.snp.makeConstraints { make in
            make.edges.equalTo(spoilerView)
        }
        
        registrationView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalTo(commentContainView).inset(8)
            make.width.equalTo(52)
        }
        
        registrationLabel.snp.makeConstraints { make in
            make.edges.equalTo(registrationView).inset(4)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.edges.equalTo(registrationView)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(spoilerView.snp.trailing).offset(8)
            make.trailing.equalTo(registrationView.snp.leading).offset(8)
            make.verticalEdges.equalTo(commentContainView)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(commentTotalView.snp.top)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 1.0
    private let headerRatio = 1.0
    private let headerAbsolute = 500.0
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.reviewLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    private func categoryLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.dynamicCategoryLayout()
                },
            configuration: configuration)
        return collectionViewLayout

    }
}

extension FeedDetailView {
    private func reviewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .absolute(216)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
//        let headerSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(headerRatio),
//            heightDimension: .estimated(headerAbsolute)
//        )
//        let header = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: FeedDetailHeaderView.identifier, alignment: .top
//        )
        
        let section = NSCollectionLayoutSection(group: group)
        
//        section.boundarySupplementaryItems = [header]
        return section
    }
}

extension FeedDetailView {
    private func dynamicCategoryLayout() -> NSCollectionLayoutSection {
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
            section.interGroupSpacing = 0
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 0)
            
            return section
        }
}

extension FeedDetailView {
    func updateSpoilerButtonUI(spoiler: Bool) {
        switch spoiler {
        case true:
            spoilerView.layer.borderColor = UIColor.purple100.cgColor
            spoilerCheckImageView.image = UIImage(named: "spoilerCheckOn")
            spoilerLabel.textColor = .white100
        case false:
            spoilerView.layer.borderColor = UIColor.black80.cgColor
            spoilerCheckImageView.image = UIImage(named: "spoilerCheckOff")
            spoilerLabel.textColor = .black60
        }
    }
}

extension FeedDetailView {
    func updateCommentTextField(textValid: Bool) {
        switch textValid {
            
        case true:
            commentTextField.textColor = .black5
            registrationLabel.textColor = .black5
        case false:
            commentTextField.textColor = .black80
            registrationLabel.textColor = .black80
        }
    }
}

extension FeedDetailView {
    func initCommentSetting() {
        commentTextField.text = nil
        updateSpoilerButtonUI(spoiler: false)
        updateCommentTextField(textValid: false)
    }
}

extension FeedDetailView {
    func updateCollectionViewHeight(cellCount: Int) {
        collectionView.snp.removeConstraints()
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(cellCount * 216)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
        collectionView.layoutIfNeeded()
    }
}
