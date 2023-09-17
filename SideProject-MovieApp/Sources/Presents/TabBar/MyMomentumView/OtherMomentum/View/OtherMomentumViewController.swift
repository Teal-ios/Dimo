//
//  OtherMomentumViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/17.
//

import UIKit
import RxCocoa
import RxSwift

final class OtherMomentumViewController: BaseViewController {
    private let otherMomentumView = OtherMomentumView()
    
    private var viewModel: OtherMomentumViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("MyMomentumViewController: fatal error")
    }
    
    init(viewModel: OtherMomentumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    let viewDidLoadTrigger = PublishRelay<Void>()
    let myProfileData = PublishRelay<MyProfile>()
    
    private var likeContentDataSource: UICollectionViewDiffableDataSource<Int, LikeContent>!
    private var digFinishDataSource: UICollectionViewDiffableDataSource<Int, MyVotedCharacter>!
    private var reviewDataSource: UICollectionViewDiffableDataSource<Int, MyReview>!
    private var likeContentSnapshot = NSDiffableDataSourceSnapshot<Int, LikeContent>()

    
    let myReviewCellSelected = PublishRelay<MyReview>()
    
    override func loadView() {
        view = otherMomentumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otherMomentumView.reviewCollectionView.delegate = self
        self.otherMomentumView.digFinishCharacherCollectionView.delegate = self
        self.otherMomentumView.profileCollectionView.delegate = self
        setLikeContentDataSource()
        setDigFinishCharacterDataSource()
        setReviewDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func setupBinding() {
        
        let input = OtherMomentumViewModel.Input(viewDidLoad: self.viewDidLoadTrigger, likeContentMoreButtonTap: self.otherMomentumView.likeContentMoreButton.rx.tap, digFinishMoreButtonTap: self.otherMomentumView.digFinishMoreButton.rx.tap, reviewMoreButtonTap: self.otherMomentumView.reviewMoreButton.rx.tap, myReviewCellSelected: self.myReviewCellSelected)
        
        let output = viewModel.transform(input: input)
        
        output.myProfileData
            .bind { [weak self] myProfile in
            guard let self else { return }
            self.myProfileData.accept(myProfile)
        }
        .disposed(by: self.disposeBag)
        
        self.myProfileData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] profile in
            guard let self else { return }
                self.otherMomentumView.profileView.configureProfileUpdate(profile: profile)
                self.otherMomentumView.configureReviewTitleUpdate(user_name: profile.nickname)
                let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in

                }
                
                reviewDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
                    let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
                    header.titleLabel.text = "\(profile.nickname)님이 쓴 리뷰"
                    return header
                })
        }
        .disposed(by: self.disposeBag)
        
        output.likeAnimationContentData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] likeAnimationContent in
                guard let self else { return }
                
                if likeAnimationContent != nil &&
                    likeAnimationContent?.like_content_info == [] {
                    self.otherMomentumView.configureProfileUpdateUI(dataExist: false)
                } else {
                    guard let likeAnimationContent else { return }
                    
                    var likeContentSnapshot = NSDiffableDataSourceSnapshot<Int, LikeContent>()
                    likeContentSnapshot.appendSections([0])
                    var sectionArr: [LikeContent] = []
                    for i in likeAnimationContent.like_content_info {
                        guard let i = i else { return }
                        sectionArr.append(i)
                    }
                    likeContentSnapshot.appendItems(sectionArr, toSection: 0)
                    self.likeContentDataSource.apply(likeContentSnapshot)
                    
                    self.otherMomentumView.configureProfileUpdateUI(dataExist: true)
                }
            }
            .disposed(by: disposeBag)
        
        output.myReviewList
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vc, myReview in
                var reviewSnapshot = NSDiffableDataSourceSnapshot<Int, MyReview>()
                reviewSnapshot.appendSections([0])
                var reviewArr: [MyReview] = []
                if myReview.review == [] {
                    vc.otherMomentumView.configureReviewUpdateUI(dataExist: false)
                } else {
                    for review in myReview.review {
                        guard let review else { return }
                        reviewArr.append(review)
                    }
                    reviewSnapshot.appendItems(reviewArr, toSection: 0)
                    print(reviewArr, "댓글 배열")
                    vc.reviewDataSource.apply(reviewSnapshot)
                    vc.otherMomentumView.configureReviewUpdateUI(dataExist: true)
                }
            }
            .disposed(by: disposeBag)
        
        output.myVotedCharacterList
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vc, myVotedCharacter in
                var votedCharacterSnapshot = NSDiffableDataSourceSnapshot<Int, MyVotedCharacter>()
                votedCharacterSnapshot.appendSections([0])
                var votedCharacterArr: [MyVotedCharacter] = []
                if myVotedCharacter.voted_character == [] {
                    vc.otherMomentumView.configureDigUpdateUI(dataExist: false)
                } else {
                    for votedCharacter in myVotedCharacter.voted_character {
                        guard let votedCharacter else { return }
                        votedCharacterArr.append(votedCharacter)
                    }
                    votedCharacterSnapshot.appendItems(votedCharacterArr, toSection: 0)
                    print(votedCharacterArr, "투표한 캐릭터 배열")

                    vc.digFinishDataSource.apply(votedCharacterSnapshot)
                    vc.otherMomentumView.configureDigUpdateUI(dataExist: true)
                }
            }
            .disposed(by: disposeBag)
    }
}

//MARK: 좋아하는 콘텐츠 collectionView 담당
extension OtherMomentumViewController {
    private func setLikeContentDataSource() {
        let cellLikeContentRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, LikeContent> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(likeContent: itemIdentifier)
        }
        
        likeContentDataSource = UICollectionViewDiffableDataSource(collectionView: otherMomentumView.profileCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellLikeContentRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let profileHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        likeContentDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: profileHeader, for: indexPath)
            header.titleLabel.text = "찜한 콘텐츠"
            return header
        })
        
        likeContentSnapshot.appendSections([0])
        var sectionArr: [LikeContent] = []
        
        for i in 1...10 {
            sectionArr.append(LikeContent(anime_id: i, poster_img: "123"))
        }
        
        likeContentSnapshot.appendItems(sectionArr, toSection: 0)
        likeContentDataSource.apply(likeContentSnapshot)
    }
}

extension OtherMomentumViewController {
    private func setDigFinishCharacterDataSource() {
        let cellDigFinishCharacterRegistration = UICollectionView.CellRegistration<DigFinishCharacterCollectionViewCell, MyVotedCharacter> { cell, indexPath, itemIdentifier in
            cell.configureUIToVotedCharacterData(with: itemIdentifier)
        }
        
        digFinishDataSource = UICollectionViewDiffableDataSource(collectionView: otherMomentumView.digFinishCharacherCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellDigFinishCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        digFinishDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            header.titleLabel.text = "Dig 완료한 캐릭터"
            return header
        })
    }
}

extension OtherMomentumViewController {
    private func setReviewDataSource() {
        let cellReviewRegistration = UICollectionView.CellRegistration<ReviewCollectionViewCell, MyReview> { cell, indexPath, itemIdentifier in
            cell.configureUpdateReviewDate(review: itemIdentifier)
        }
        
        reviewDataSource = UICollectionViewDiffableDataSource(collectionView: otherMomentumView.reviewCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellReviewRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

extension OtherMomentumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.otherMomentumView.profileCollectionView:
            print("내찜꽁")
        case self.otherMomentumView.digFinishCharacherCollectionView:
            print("캐릭터")
        case self.otherMomentumView.reviewCollectionView:
            self.myReviewCellDataFetching(indexPath: indexPath)
        default:
            print("이상한컬렉션뷰")
        }
    }
}

extension OtherMomentumViewController {
    private func myReviewCellDataFetching(indexPath: IndexPath) {
        let selectedItem = reviewDataSource.snapshot().itemIdentifiers[indexPath.row]
        self.myReviewCellSelected.accept(selectedItem)
    }
}

