//
//  EditMyInfoViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxSwift
import RxCocoa

final class EditMyInfoViewController: BaseViewController {
    let selfView = EditMyInfoView()
    
    private var viewModel: EditMyInfoViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("EditMyInfoViewController: fatal error")
    }
    
    init(viewModel: EditMyInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, SettingModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, SettingModel>()
    
    let cellSelected = PublishSubject<IndexPath>()
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selfView.collectionView.delegate = self
        self.setDataSource()
        self.applySnapshot()
    }
    
    override func setupBinding() {
        let input = EditMyInfoViewModel.Input(cellSelected: self.cellSelected)
        let output = self.viewModel.transform(input: input)
    }
    
    func setDataSource() {
        let cellSettingRegistration = UICollectionView.CellRegistration<SettingBaseCollectionViewCell, SettingModel> { cell, indexPath,
            itemIdentifier in
            
            cell.titleLabel.text = itemIdentifier.title
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellSettingRegistration, for: indexPath, item: itemIdentifier)
            return cell
            
        }
        let titleSettingHeader = UICollectionView.SupplementaryRegistration<TitleSettingHeaderView>(elementKind: TitleSettingHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: titleSettingHeader, for: indexPath)
            header.mainTitleLable.text = "내 정보 변경"
            return header
        })
    }
    
    func applySnapshot() {
        snapshot.appendSections([0])
        var myInfoArr: [SettingModel] = []
        
        myInfoArr.append(SettingModel(title: "닉네임 변경"))
        myInfoArr.append(SettingModel(title: "비밀번호 변경"))
        myInfoArr.append(SettingModel(title: "로그아웃"))
        myInfoArr.append(SettingModel(title: "회원탈퇴"))

        snapshot.appendItems(myInfoArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}

extension EditMyInfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cellSelected.onNext(indexPath)
    }
}
