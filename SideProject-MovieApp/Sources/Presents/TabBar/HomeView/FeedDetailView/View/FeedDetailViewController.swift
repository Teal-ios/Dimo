//
//  FeedDetailViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import RxSwift
import RxCocoa

class FeedDetailViewController: BaseViewController {
    private let feedDetailView = FeedDetailView()
    
    private var viewModel: FeedDetailViewModel
    
    override func loadView() {
        view = feedDetailView
    }
    
    init(viewModel: FeedDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    var categoryDataSource: UICollectionViewDiffableDataSource<Int, CategoryModel>!
    var dataSource: UICollectionViewDiffableDataSource<Int, CommentList>!
    
    let plusNavigationButtonTap = PublishSubject<Void>()
    let spoilerValid = PublishRelay<Bool>()
    let review = PublishRelay<ReviewList>()
    let viewDidLoadTrigger = PublishRelay<Void>()
    let setDataSourceApplySnapshotAfter = PublishRelay<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        plusNavigationItemSet()
        setCategoryDataSource()
        setDataSource()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    override func setupBinding() {
        let input = FeedDetailViewModel.Input(plusNavigationButtonTapped: self.plusNavigationButtonTap, spoilerButtonTapped: self.feedDetailView.spoilerButton.rx.tap, commentText: self.feedDetailView.commentTextField.rx.text, viewDidLoad: self.viewDidLoadTrigger, commentRegisterButtonTap: self.feedDetailView.registrationButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.spoilerValid
            .observe(on: MainScheduler.instance)
            .bind { [weak self] bool in
                guard let self else { return }
                print(bool, "스포일러 여부")
                self.feedDetailView.updateSpoilerButtonUI(spoiler: bool)
            }
            .disposed(by: disposeBag)

        output.textValid
            .observe(on: MainScheduler.instance)
            .bind { [weak self] valid in
                guard let self else { return }
                self.feedDetailView.updateCommentTextField(textValid: valid)
            }
            .disposed(by: disposeBag)
        
        output.review
            .withUnretained(self)
            .bind { vc, review in
                print(review, "여기는 잘 들어가")
                vc.feedDetailView.headerView.configureFeedDetailHeaderView(with: review)
            }
            .disposed(by: disposeBag)
        
        output.commentList
            .withUnretained(self)
            .bind { vc, commentList in
                if commentList != [] {
                    var commentSnapshot = NSDiffableDataSourceSnapshot<Int, CommentList>()
                    commentSnapshot.appendSections([0])
                    var sectionArr: [CommentList] = []
                    for comment in commentList {
                        guard let comment else { return }
                        sectionArr.append(comment)
                    }
                    commentSnapshot.appendItems(sectionArr, toSection: 0)
                    self.dataSource.apply(commentSnapshot)
                    self.setDataSourceApplySnapshotAfter.accept(sectionArr.count)
                }
            }
            .disposed(by: disposeBag)
        
        output.commentList
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vc, _ in
                vc.feedDetailView.initCommentSetting()
            }
            .disposed(by: disposeBag)
        
        self.setDataSourceApplySnapshotAfter
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, cellCount in
                vc.feedDetailView.updateCollectionViewHeight(cellCount: cellCount)
            }
            .disposed(by: disposeBag)
        
        output.reviewDetail
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, reviewDetail in
                var categorySnapshot = NSDiffableDataSourceSnapshot<Int, CategoryModel>()

                categorySnapshot.appendSections([0])
                var categoryArr: [CategoryModel] = []
                let category = reviewDetail.review_list[0]
                if category.review_spoiler == 1 {
                    categoryArr.append(CategoryModel(category: "스포주의", spoil: true))
                }
                categoryArr.append(CategoryModel(category: category.character_name ?? "정대만", spoil: false))
                categoryArr.append(CategoryModel(category: category.mbti ?? "미정", spoil: false))
                categoryArr.append(CategoryModel(category: category.title ?? "더퍼스트슬램덩크", spoil: false))


                categorySnapshot.appendItems(categoryArr, toSection: 0)
                vc.categoryDataSource.apply(categorySnapshot)
            }
            .disposed(by: disposeBag)
    }
}

extension FeedDetailViewController {
    func setCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CategoryCollectionViewCell, CategoryModel> {  cell, indexPath, itemIdentifier in
            cell.categoryLabel.text = itemIdentifier.category
            if itemIdentifier.spoil == true {
                cell.bgView.backgroundColor = .purple20
                cell.categoryLabel.textColor = .purple100
            }
        }
        
        categoryDataSource = UICollectionViewDiffableDataSource(collectionView: feedDetailView.categoryCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

extension FeedDetailViewController {
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DetailReviewCollectionViewCell, CommentList> {  cell, indexPath, itemIdentifier in
            cell.configureCommentAttribute(with: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: feedDetailView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

extension FeedDetailViewController {
    private func plusNavigationItemSet() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "vertical_ellipsis"), style: .plain, target: self, action: #selector(plusButtonClicked))
        self.navigationItem.rightBarButtonItem?.tintColor = .black60

    }
    
    @objc
    func plusButtonClicked() {
        self.plusNavigationButtonTap.onNext(())
    }
}

extension FeedDetailViewController {
    // 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= keyboardHeight
        }
    }

    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y += keyboardHeight
        }
    }
}
