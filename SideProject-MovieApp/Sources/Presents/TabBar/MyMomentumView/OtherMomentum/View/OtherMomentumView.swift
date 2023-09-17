//
//  OtherMomentumView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/17.
//

import UIKit
import SnapKit

class OtherMomentumView: BaseView {
    
    lazy var containScrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(profileView)
        view.addSubview(profileStackView)
        view.addSubview(digStackView)
        view.addSubview(reivewStackView)
        return view
    }()
    
    let profileView: OtherProfileView = {
        let view = OtherProfileView()
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
    
    
    let exceptionHandlingLikeContentView: MyMomentumBaseExceptionHandlingView = {
        let view = MyMomentumBaseExceptionHandlingView(title: "찜한 콘텐츠", subtitle: "찜한 콘텐츠가 없어요")
        return view
    }()
    
    let exceptionHandlingDigView: MyMomentumBaseExceptionHandlingView = {
        let view = MyMomentumBaseExceptionHandlingView(title: "Dig 완료한 캐릭터", subtitle: "아직 기록이 없어요")
        return view
    }()
    
    let exceptionHandlingReviewView: MyMomentumBaseExceptionHandlingView = {
        let view = MyMomentumBaseExceptionHandlingView(title: "디모최고님이 쓴 리뷰", subtitle: "작성된 리뷰가 없어요")
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
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setHierarchy() {
        self.addSubview(containScrollView)
        self.addSubview(likeContentMoreButton)
        self.addSubview(digFinishMoreButton)
        self.addSubview(reviewMoreButton)
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
            make.height.equalTo(350)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(104)
        }
        
        digStackView.snp.makeConstraints { make in
            make.top.equalTo(profileStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(104)
        }
        
        reivewStackView.snp.makeConstraints { make in
            make.top.equalTo(digStackView.snp.bottom)
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

extension OtherMomentumView {
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

extension OtherMomentumView {
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

extension OtherMomentumView {
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

extension OtherMomentumView {
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

extension OtherMomentumView {
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

extension OtherMomentumView {
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

extension OtherMomentumView {
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
            make.height.equalTo(104)
        }
        self.digFinishMoreButton.isEnabled = false
        self.layoutIfNeeded()
    }
}

extension OtherMomentumView {
    func updateReviewExistLayout() {
        self.reivewStackView.snp.remakeConstraints { make in
            make.top.equalTo(digStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
        self.reviewMoreButton.isEnabled = true
        self.layoutIfNeeded()
    }
    
    func updateReviewNonexistentLayout() {
        reivewStackView.snp.makeConstraints { make in
            make.top.equalTo(digStackView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(104)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
        self.reviewMoreButton.isEnabled = false
        self.layoutIfNeeded()
    }
}

extension OtherMomentumView {
    func configureReviewTitleUpdate(user_name: String) {
        exceptionHandlingReviewView.titleLabel.text = "\(user_name)님이 쓴 리뷰"
    }
}
