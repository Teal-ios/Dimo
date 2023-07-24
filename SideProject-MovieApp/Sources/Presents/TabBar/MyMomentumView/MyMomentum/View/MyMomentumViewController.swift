//
//  MyMomentumViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import RxCocoa
import RxSwift

class MyMomentumViewController: BaseViewController {
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
    private var digFinishDataSource: UICollectionViewDiffableDataSource<Int, MyMomentumModel>!
    private var reviewDataSource: UICollectionViewDiffableDataSource<Int, MyMomentumModel>!
    private var commentDataSource: UICollectionViewDiffableDataSource<Int, MyMomentumModel>!
    private var likeContentSnapshot = NSDiffableDataSourceSnapshot<Int, LikeContent>()
    private var digFinishSnapshot = NSDiffableDataSourceSnapshot<Int, MyMomentumModel>()
    private var reviewSnapshot = NSDiffableDataSourceSnapshot<Int, MyMomentumModel>()
    private var commentSnapshot = NSDiffableDataSourceSnapshot<Int, MyMomentumModel>()
    
    override func loadView() {
        view = myMomentumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setNavigation()
        setLikeContentDataSource()
        setDigFinishCharacterDataSource()
        setReviewDataSource()
        setCommentDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func setupBinding() {
        let input = MyMomentumViewModel.Input(viewDidLoad: self.viewDidLoadTrigger)
        
        let output = viewModel.transform(input: input)
        
        output.myProfileData.bind { [weak self] myProfile in
            guard let self else { return }
            self.myProfileData.accept(myProfile)
        }
        .disposed(by: self.disposeBag)
        
    }
}

//MARK: 좋아하는 콘텐츠 collectionView 담당
extension MyMomentumViewController {
    private func setLikeContentDataSource() {
        let cellLikeContentRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, LikeContent> { cell, indexPath, itemIdentifier in
        }
        
        likeContentDataSource = UICollectionViewDiffableDataSource(collectionView: myMomentumView.profileCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellLikeContentRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let ProfileHeader = UICollectionView.SupplementaryRegistration<ProfileHeaderView>(elementKind: ProfileHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        likeContentDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: ProfileHeader, for: indexPath)
            self.myProfileData
                .observe(on: MainScheduler.instance)
                .bind { [weak self] profile in
                guard let self else { return }
                header.profileView.configureProfileUpdate(profile: profile)
            }
            .disposed(by: self.disposeBag)
            return header
        })
        
        likeContentSnapshot.appendSections([0])
        var sectionArr: [LikeContent] = []
        
        for i in 1...10 {
            sectionArr.append(LikeContent(content_type: "", content_id: i))
        }
        
        likeContentSnapshot.appendItems(sectionArr, toSection: 0)
        likeContentDataSource.apply(likeContentSnapshot)
    }
}

extension MyMomentumViewController {
    private func setDigFinishCharacterDataSource() {
        let cellDigFinishCharacterRegistration = UICollectionView.CellRegistration<DigFinishCharacterCollectionViewCell, MyMomentumModel> { cell, indexPath, itemIdentifier in
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
        
        digFinishSnapshot.appendSections([0])
        var sectionArr: [MyMomentumModel] = []
        
        for _ in 1...10 {
            sectionArr.append(MyMomentumModel(image: nil))
        }
        
        digFinishSnapshot.appendItems(sectionArr, toSection: 0)
        digFinishDataSource.apply(digFinishSnapshot)
    }
}

extension MyMomentumViewController {
    private func setReviewDataSource() {
        let cellReviewRegistration = UICollectionView.CellRegistration<ReviewCollectionViewCell, MyMomentumModel> { cell, indexPath, itemIdentifier in
            
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
        
        reviewSnapshot.appendSections([0])
        var sectionArr: [MyMomentumModel] = []
        
        for _ in 1...10 {
            sectionArr.append(MyMomentumModel(image: nil))
        }
        
        reviewSnapshot.appendItems(sectionArr, toSection: 0)
        reviewDataSource.apply(reviewSnapshot)
    }
}

extension MyMomentumViewController {
    private func setCommentDataSource() {
        let cellCommentRegistration = UICollectionView.CellRegistration<ReviewCollectionViewCell, MyMomentumModel> { cell, indexPath, itemIdentifier in
            
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
        
        commentSnapshot.appendSections([0])
        var sectionArr: [MyMomentumModel] = []
        
        for _ in 1...10 {
            sectionArr.append(MyMomentumModel(image: nil))
        }
        
        commentSnapshot.appendItems(sectionArr, toSection: 0)
        commentDataSource.apply(commentSnapshot)
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
