//
//  MyMomentumViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import RxCocoa
import RxSwift

final class MyMomentumViewController: BaseViewController {
    private let myMomentumView = MyMomentumView()
    
    private var viewModel: MyMomentumViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("MyMomentumViewController: fatal error")
    }
    
    init(viewModel: MyMomentumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    let viewDidLoadTrigger = PublishRelay<Void>()
    let myProfileData = PublishRelay<MyProfile>()
    
    private var likeContentDataSource: UICollectionViewDiffableDataSource<Int, LikeContent>!
    private var digFinishDataSource: UICollectionViewDiffableDataSource<Int, MyVotedCharacter>!
    private var reviewDataSource: UICollectionViewDiffableDataSource<Int, MyReview>!
    private var commentDataSource: UICollectionViewDiffableDataSource<Int, MyComment>!
    private var likeContentSnapshot = NSDiffableDataSourceSnapshot<Int, LikeContent>()
//    private var digFinishSnapshot = NSDiffableDataSourceSnapshot<Int, MyVotedCharacter>()
//    private var reviewSnapshot = NSDiffableDataSourceSnapshot<Int, MyReview>()
//    private var commentSnapshot = NSDiffableDataSourceSnapshot<Int, MyComment>()
    
    let myReviewCellSelected = PublishRelay<MyReview>()
    let myCommentCellSelected = PublishRelay<MyComment>()
    let myLikeContentCellSelected = PublishRelay<LikeContent>()
    let myDigCharacterCellSelected = PublishRelay<MyVotedCharacter>()
    
    override func loadView() {
        view = myMomentumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myMomentumView.reviewCollectionView.delegate = self
        self.myMomentumView.commentCollectionView.delegate = self
        self.myMomentumView.digFinishCharacherCollectionView.delegate = self
        self.myMomentumView.profileCollectionView.delegate = self
//        setNavigation()
        setLikeContentDataSource()
        setDigFinishCharacterDataSource()
        setReviewDataSource()
        setCommentDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func setupBinding() {
        
        let input = MyMomentumViewModel.Input(viewDidLoad: self.viewDidLoadTrigger, editProfileButtonTap: self.myMomentumView.profileView.profileSettingButton.rx.tap, likeContentMoreButtonTap: self.myMomentumView.likeContentMoreButton.rx.tap, digFinishMoreButtonTap: self.myMomentumView.digFinishMoreButton.rx.tap, reviewMoreButtonTap: self.myMomentumView.reviewMoreButton.rx.tap, commentMoreButtonTap: self.myMomentumView.commentMoreButton.rx.tap, myReviewCellSelected: self.myReviewCellSelected, myCommentCellSelected: self.myCommentCellSelected, myLikeContentCellSelected: self.myLikeContentCellSelected, myDigCharacterCellSelected: self.myDigCharacterCellSelected)
        
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
                self.myMomentumView.profileView.configureProfileUpdate(profile: profile)
        }
        .disposed(by: self.disposeBag)
        
        output.likeAnimationContentData
            .observe(on: MainScheduler.instance)
            .bind { [weak self] likeAnimationContent in
                guard let self else { return }
                
                if likeAnimationContent != nil &&
                    likeAnimationContent?.like_content_info == [] {
                    self.myMomentumView.configureProfileUpdateUI(dataExist: false)
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
                    
                    self.myMomentumView.configureProfileUpdateUI(dataExist: true)
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
                    vc.myMomentumView.configureReviewUpdateUI(dataExist: false)
                } else {
                    for review in myReview.review {
                        guard let review else { return }
                        reviewArr.append(review)
                    }
                    reviewSnapshot.appendItems(reviewArr, toSection: 0)
                    print(reviewArr, "댓글 배열")
                    vc.reviewDataSource.apply(reviewSnapshot)
                    vc.myMomentumView.configureReviewUpdateUI(dataExist: true)
                }
            }
            .disposed(by: disposeBag)
        
        output.myCommentList
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vc, myComment in
                var commentSnapshot = NSDiffableDataSourceSnapshot<Int, MyComment>()
                commentSnapshot.appendSections([0])
                var commentArr: [MyComment] = []
                if myComment.comment == [] {
                    vc.myMomentumView.configureCommentUpdateUI(dataExist: false)
                } else {
                    for comment in myComment.comment {
                        guard let comment else { return }
                        commentArr.append(comment)
                    }
                    commentSnapshot.appendItems(commentArr, toSection: 0)
                    print(commentArr, "댓글 배열")
                    vc.commentDataSource.apply(commentSnapshot)
                    vc.myMomentumView.configureCommentUpdateUI(dataExist: true)
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
                    vc.myMomentumView.configureDigUpdateUI(dataExist: false)
                } else {
                    for votedCharacter in myVotedCharacter.voted_character {
                        guard let votedCharacter else { return }
                        votedCharacterArr.append(votedCharacter)
                    }
                    votedCharacterSnapshot.appendItems(votedCharacterArr, toSection: 0)
                    print(votedCharacterArr, "투표한 캐릭터 배열")

                    vc.digFinishDataSource.apply(votedCharacterSnapshot)
                    vc.myMomentumView.configureDigUpdateUI(dataExist: true)
                }
            }
            .disposed(by: disposeBag)
        
    }
}

//MARK: 좋아하는 콘텐츠 collectionView 담당
extension MyMomentumViewController {
    private func setLikeContentDataSource() {
        let cellLikeContentRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, LikeContent> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(likeContent: itemIdentifier)
        }
        
        likeContentDataSource = UICollectionViewDiffableDataSource(collectionView: myMomentumView.profileCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellLikeContentRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let profileHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        likeContentDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: profileHeader, for: indexPath)

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

extension MyMomentumViewController {
    private func setDigFinishCharacterDataSource() {
        let cellDigFinishCharacterRegistration = UICollectionView.CellRegistration<DigFinishCharacterCollectionViewCell, MyVotedCharacter> { cell, indexPath, itemIdentifier in
            cell.configureUIToVotedCharacterData(with: itemIdentifier)
        }
        
        digFinishDataSource = UICollectionViewDiffableDataSource(collectionView: myMomentumView.digFinishCharacherCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
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

extension MyMomentumViewController {
    private func setReviewDataSource() {
        let cellReviewRegistration = UICollectionView.CellRegistration<ReviewCollectionViewCell, MyReview> { cell, indexPath, itemIdentifier in
            cell.configureUpdateReviewDate(review: itemIdentifier)
        }
        
        reviewDataSource = UICollectionViewDiffableDataSource(collectionView: myMomentumView.reviewCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellReviewRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in

        }
        
        reviewDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            header.titleLabel.text = "내가 쓴 리뷰"
            return header
        })
    }
}

extension MyMomentumViewController {
    private func setCommentDataSource() {
        let cellCommentRegistration = UICollectionView.CellRegistration<ReviewCollectionViewCell, MyComment> { cell, indexPath, itemIdentifier in
            cell.configureUpdateCommentDate(comment: itemIdentifier)
        }
        
        commentDataSource = UICollectionViewDiffableDataSource(collectionView: myMomentumView.commentCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellCommentRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        commentDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            header.titleLabel.text = "내가 쓴 댓글"
            
            return header
        })
    }
}

extension MyMomentumViewController {
    private func setNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "bell"), style: .plain, target: self, action: #selector(bellButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .black60
    }
    
    @objc
    func bellButtonTapped() {
        
    }
}

extension MyMomentumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.myMomentumView.profileCollectionView:
            self.myLikeContentCellDataFetching(indexPath: indexPath)
        case self.myMomentumView.digFinishCharacherCollectionView:
            self.myDigCharacterCellDataFetching(indexPath: indexPath)
        case self.myMomentumView.reviewCollectionView:
            self.myReviewCellDataFetching(indexPath: indexPath)
        case self.myMomentumView.commentCollectionView:
            self.myCommentCellDataFetching(indexPath: indexPath)
        default:
            print("이상한컬렉션뷰")
        }
    }
}

extension MyMomentumViewController {
    private func myReviewCellDataFetching(indexPath: IndexPath) {
        let selectedItem = reviewDataSource.snapshot().itemIdentifiers[indexPath.row]
        self.myReviewCellSelected.accept(selectedItem)
    }
}

extension MyMomentumViewController {
    private func myCommentCellDataFetching(indexPath: IndexPath) {
        let selectedItem = commentDataSource.snapshot().itemIdentifiers[indexPath.row]
        self.myCommentCellSelected.accept(selectedItem)
    }
}

extension MyMomentumViewController {
    private func myLikeContentCellDataFetching(indexPath: IndexPath) {
        let selectedItem = likeContentDataSource.snapshot().itemIdentifiers[indexPath.row]
        self.myLikeContentCellSelected.accept(selectedItem)
    }
}

extension MyMomentumViewController {
    private func myDigCharacterCellDataFetching(indexPath: IndexPath) {
        let selectedItem = digFinishDataSource.snapshot().itemIdentifiers[indexPath.row]
        self.myDigCharacterCellSelected.accept(selectedItem)
    }
}
