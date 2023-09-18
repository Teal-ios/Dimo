//
//  MyMomentumView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import SnapKit

class MyMomentumView: BaseView {
    
    lazy var containScrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(profileView)
        view.addSubview(profileStackView)
        view.addSubview(digStackView)
        view.addSubview(reivewStackView)
        view.addSubview(commentStackView)
        return view
    }()
    
    let profileView: ProfileView = {
        let view = ProfileView()
        return view
    }()
    
    lazy var profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createProfileLayout())
    lazy var digFinishCharacherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createDigFinishLayout())
    lazy var reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createReviewCommentLayout())
    lazy var commentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createReviewCommentLayout())
    
    lazy var profileStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(profileCollectionView)
        view.addArrangedSubview(exceptionHandlingLikeContentView)
        return view
    }()
    
    lazy var digStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(digFinishCharacherCollectionView)
        view.addArrangedSubview(exceptionHandlingDigView)
        return view
    }()
    lazy var reivewStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(reviewCollectionView)
        view.addArrangedSubview(exceptionHandlingReviewView)
        return view
    }()
    
    lazy var commentStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(commentCollectionView)
        view.addArrangedSubview(exceptionHandlingCommentView)
        return view
    }()
    
    let exceptionHandlingLikeContentView: MyMomentumBaseExceptionHandlingView = {
        let view = MyMomentumBaseExceptionHandlingView(title: "내가 찜한 콘텐츠", subtitle: "내가 찜한 콘텐츠가 없어요")
        return view
    }()
    
    let exceptionHandlingDigView: MyMomentumDigExceptionHandlingView = {
        let view = MyMomentumDigExceptionHandlingView(title: "Dig 완료한 캐릭터", subtitle: "아직 기록이 없어요")
        return view
    }()
    
    let exceptionHandlingReviewView: MyMomentumBaseExceptionHandlingView = {
        let view = MyMomentumBaseExceptionHandlingView(title: "내가 쓴 리뷰", subtitle: "작성된 리뷰가 없어요")
        return view
    }()
    
    let exceptionHandlingCommentView: MyMomentumBaseExceptionHandlingView = {
        let view = MyMomentumBaseExceptionHandlingView(title: "내가 쓴 댓글", subtitle: "작성한 댓글이 없어요")
        return view
    }()
    
    let likeContentMoreButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let digFinishMoreButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let reviewMoreButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let commentMoreButton: UIButton = {
        let button = UIButton()
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setHierarchy() {
        self.addSubview(containScrollView)
        self.addSubview(likeContentMoreButton)
        self.addSubview(digFinishMoreButton)
        self.addSubview(reviewMoreButton)
        self.addSubview(commentMoreButton)
    }
    
    override func setupAttributes() {
        self.profileCollectionView.isScrollEnabled = false
        self.digFinishCharacherCollectionView.isScrollEnabled = false
        self.reviewCollectionView.isScrollEnabled = false
        self.commentCollectionView.isScrollEnabled = false
    }
    
    override func setupLayout() {
        containScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(containScrollView.snp.top)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(342)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(104)
        }
        
        digStackView.snp.makeConstraints { make in
            make.top.equalTo(profileStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(216)
        }
        
        reivewStackView.snp.makeConstraints { make in
            make.top.equalTo(digStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(104)
        }
        
        commentStackView.snp.makeConstraints { make in
            make.top.equalTo(reivewStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(104)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
        
        likeContentMoreButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(profileStackView)
            make.width.equalTo(72)
            make.height.equalTo(44)
        }
        
        digFinishMoreButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(digStackView)
            make.width.equalTo(72)
            make.height.equalTo(44)
        }
        
        reviewMoreButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(reivewStackView)
            make.width.equalTo(72)
            make.height.equalTo(44)
        }
        
        commentMoreButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(commentStackView)
            make.width.equalTo(72)
            make.height.equalTo(44)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 0.93
    private let headerRatio = 1.0
    private let headerAbsolute = 40.0
    
    private func createProfileLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            default: return self.profileLayout()
            }
        }, configuration: configuration)
        return collectionViewLayout
    }
    
    private func createDigFinishLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            default: return self.characterLayout()
            }
        }, configuration: configuration)
        return collectionViewLayout
    }
    
    private func createReviewCommentLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            default: return self.reviewLayout()
            }
        }, configuration: configuration)
        return collectionViewLayout
    }
    
    private func profileLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio / 1.2)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MyMomentumHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}

extension MyMomentumView {
    private func characterLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)

        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MyMomentumHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}

extension MyMomentumView {
    private func reviewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)

        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .absolute(168)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MyMomentumHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}

extension MyMomentumView {
    func configureProfileUpdateUI(dataExist: Bool) {
        if dataExist {
            self.exceptionHandlingLikeContentView.isHidden = true
            self.profileCollectionView.isHidden = false
            updateProfileExistLayout()
        } else {
            self.exceptionHandlingLikeContentView.isHidden = false
            self.profileCollectionView.isHidden = true
            updateProfileNonexistentLayout()
        }
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func configureDigUpdateUI(dataExist: Bool) {
        if dataExist == true {
            self.exceptionHandlingDigView.isHidden = true
            self.digFinishCharacherCollectionView.isHidden = false
            updateDigExistLayout()
        } else {
            self.exceptionHandlingDigView.isHidden = false
            self.digFinishCharacherCollectionView.isHidden = true
            updateDigNonexistentLayout()
        }
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func configureReviewUpdateUI(dataExist: Bool) {
        if dataExist == true {
            self.exceptionHandlingReviewView.isHidden = true
            self.reviewCollectionView.isHidden = false
            updateReviewExistLayout()
        } else {
            self.exceptionHandlingReviewView.isHidden = false
            self.reviewCollectionView.isHidden = true
            updateReviewNonexistentLayout()
        }
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func configureCommentUpdateUI(dataExist: Bool) {
        if dataExist == true {
            self.exceptionHandlingCommentView.isHidden = true
            self.commentCollectionView.isHidden = false
            updateCommentExistLayout()
        } else {
            self.exceptionHandlingCommentView.isHidden = false
            self.commentCollectionView.isHidden = true
            updateCommentNonexistentLayout()
        }
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func updateProfileExistLayout() {
        self.profileStackView.snp.remakeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        self.likeContentMoreButton.isEnabled = true
        self.layoutIfNeeded()
    }
    
    func updateProfileNonexistentLayout() {
        profileStackView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(104)
        }
        self.likeContentMoreButton.isEnabled = false
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func updateDigExistLayout() {
        self.digStackView.snp.remakeConstraints { make in
            make.top.equalTo(profileStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        self.digFinishMoreButton.isEnabled = true
        self.layoutIfNeeded()
    }
    
    func updateDigNonexistentLayout() {
        digStackView.snp.makeConstraints { make in
            make.top.equalTo(profileStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(160)
        }
        self.digFinishMoreButton.isEnabled = false
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func updateReviewExistLayout() {
        self.reivewStackView.snp.remakeConstraints { make in
            make.top.equalTo(digStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        self.reviewMoreButton.isEnabled = true
        self.layoutIfNeeded()
    }
    
    func updateReviewNonexistentLayout() {
        reivewStackView.snp.makeConstraints { make in
            make.top.equalTo(digStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(104)
        }
        self.reviewMoreButton.isEnabled = false
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func updateCommentExistLayout() {
        self.commentStackView.snp.remakeConstraints { make in
            make.top.equalTo(reivewStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
        self.commentMoreButton.isEnabled = true
        self.layoutIfNeeded()
    }
    
    func updateCommentNonexistentLayout() {
        commentStackView.snp.makeConstraints { make in
            make.top.equalTo(reivewStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(104)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
        self.commentMoreButton.isEnabled = false
        self.layoutIfNeeded()
    }
}
