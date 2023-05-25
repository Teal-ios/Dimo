//
//  SettingViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    let settingView = SettingView()
    
    private var viewModel: SettingViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("SettingViewController: fatal error")
    }
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, SettingModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, SettingModel>()
    
    let cellSelected = PublishSubject<IndexPath>()
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingView.collectionView.delegate = self
        setDataSource()
    }
    
    override func setupBinding() {
        let input = SettingViewModel.Input(cellSelected: self.cellSelected)
        let output = self.viewModel.transform(input: input)
    }
    
    func setDataSource() {
        let cellSettingRegistration = UICollectionView.CellRegistration<SettingBaseCollectionViewCell, SettingModel> { cell, indexPath,
            itemIdentifier in
            
            cell.titleLabel.text = itemIdentifier.title
        }
        
        let cellEtcRegistration = UICollectionView.CellRegistration<SettingEtcCollectionViewCell, SettingModel> { cell, indexPath, itemIdentifier in
            
            cell.titleLabel.text = itemIdentifier.title
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: settingView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellSettingRegistration, for: indexPath, item: itemIdentifier)
                return cell
            case 1:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellSettingRegistration, for: indexPath, item: itemIdentifier)
                return cell
            case 2:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellSettingRegistration, for: indexPath, item: itemIdentifier)
                return cell
            default:
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellEtcRegistration, for: indexPath, item: itemIdentifier)
                return cell
            }
        }
        
        let titleSettingHeader = UICollectionView.SupplementaryRegistration<TitleSettingHeaderView>(elementKind: TitleSettingHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        
        let settingHeader = UICollectionView.SupplementaryRegistration<SettingHeaderView>(elementKind: SettingHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: titleSettingHeader, for: indexPath)
                header.titleLabel.text = "계정 설정"
                return header
            case 1:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: settingHeader, for: indexPath)
                header.titleLabel.text = "알림 설정"
                return header
            case 2:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: settingHeader, for: indexPath)
                header.titleLabel.text = "고객센터"
                return header
            default:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: settingHeader, for: indexPath)
                header.titleLabel.text = "기타"
                return header
            }
        })
        
        snapshot.appendSections([0, 1, 2, 3])
        var acountArr: [SettingModel] = []
        var notificationArr: [SettingModel] = []
        var customerArr: [SettingModel] = []
        var etcArr: [SettingModel] = []
        
        acountArr.append(SettingModel(title: "내 정보 변경"))
        acountArr.append(SettingModel(title: "MBTI 변경"))
        
        notificationArr.append(SettingModel(title: "푸시 알림"))
        notificationArr.append(SettingModel(title: "키워드 알림"))
        customerArr.append(SettingModel(title: "공지사항"))
        customerArr.append(SettingModel(title: "자주 묻는 질문"))
        customerArr.append(SettingModel(title: "1:1 문의"))
        customerArr.append(SettingModel(title: "캐릭터 요청하기"))
        
        etcArr.append(SettingModel(title: "서비스 이용약관"))
        etcArr.append(SettingModel(title: "개인정보 취급 방침"))
        etcArr.append(SettingModel(title: "오픈소스 라이선스"))
        etcArr.append(SettingModel(title: "버전 정보"))
        
        snapshot.appendItems(acountArr, toSection: 0)
        snapshot.appendItems(notificationArr, toSection: 1)
        snapshot.appendItems(customerArr, toSection: 2)
        snapshot.appendItems(etcArr, toSection: 3)
        
        dataSource.apply(snapshot)
    }
}

extension SettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cellSelected.onNext(indexPath)
    }
}
