//
//  MBTINotificationViewController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/02.
//

import UIKit
import RxSwift
import RxCocoa

final class MBTIKeywordNotificationViewController: BaseViewController {
    
    enum Section: Int, CaseIterable {
        case allMbti
        case registeredMbti
    }
    
    struct MBTI: Hashable {
        let id = UUID()
        var mbti: String
        var isSelected: Bool = false
    }
    
    let mbtiKeywordNotificationView = MBTIKeywordNotificationView()
    let viewModel: MBTINotificationViewModel
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MBTI>!
    private var registredMbtiCellSelected = PublishRelay<MBTI>()
    private var headerLabelText = BehaviorRelay<String>(value: "")
    
    private let mbtiArr: [String] = ["ISTJ", "ISFJ", "INFJ", "INTJ", "ISTP", "ISFP", "INFP", "INTP", "ESTP", "ESFP", "ENFP", "ENTP", "ESTJ", "ESFJ", "ENFJ", "ENTJ"]
    
    private lazy var mbtiList: [MBTI] = mbtiArr.map { MBTI(mbti: $0) }
    private var registeredMbtiList: [MBTI] = []
    
    init(viewModel: MBTINotificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = mbtiKeywordNotificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mbtiKeywordNotificationView.collectionView.delegate = self
        self.configureDatasource()
        self.applySnapshot()
        self.bind()
    }
    
    func bind() {
        registredMbtiCellSelected
            .withUnretained(self)
            .bind { (vc, item) in
                guard let index = vc.mbtiList.map({ $0.mbti }).firstIndex(of: item.mbti) else { return }
                vc.mbtiList[index].isSelected = item.isSelected
            }
            .disposed(by: disposeBag)
    }
    
    func configureDatasource() {
        let cellRegistration = UICollectionView.CellRegistration<AllMbtiCollectionViewCell, MBTI> { cell, indexPath, itemIdentifier in
            cell.configure(text: itemIdentifier.mbti)
            cell.configureUI(isSelected: itemIdentifier.isSelected)
        }

        let cellRegistration2 = UICollectionView.CellRegistration<RegisteredMbtiCollectionViewCell, MBTI>  { cell, indexPath, itemIdentifier in
            cell.configure(text: itemIdentifier.mbti)
            
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, MBTI>(collectionView: mbtiKeywordNotificationView.collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            switch Section(rawValue: indexPath.section) {
            case .allMbti:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            case .registeredMbti:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration2, for: indexPath, item: itemIdentifier)
            case .none:
                return .init()
            }
        })
        
        let registeredKeywordHeaderView = UICollectionView.SupplementaryRegistration<RegisteredKeywordHeaderView>(elementKind: RegisteredKeywordHeaderView.reuseIdentifier) { supplementaryView, elementKind, indexPath in
        
        }
        
        self.dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: registeredKeywordHeaderView, for: indexPath)
            
            self.headerLabelText
                .withUnretained(self)
                .bind { (vc, text) in
                    header.headerLabel.text = text
                }
                .disposed(by: self.disposeBag)
            
            return header
        })
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MBTI>()
        snapshot.appendSections([.allMbti, .registeredMbti])
        snapshot.appendItems(mbtiList, toSection: .allMbti)
        snapshot.appendItems(registeredMbtiList, toSection: .registeredMbti)
        dataSource.apply(snapshot)
    }
}

extension MBTIKeywordNotificationViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .allMbti:
            let cellIsSelected = mbtiList[indexPath.item].isSelected
            guard !cellIsSelected else { return }
            
            let selectedMbti = mbtiList[indexPath.item].mbti
            let isRegisteredMbti = registeredMbtiList.contains { MBTI in
                return MBTI.mbti == selectedMbti
            }
  
            guard !isRegisteredMbti && registeredMbtiList.count < 5 else { return }
            registeredMbtiList.append(MBTI(mbti: selectedMbti))
            mbtiList[indexPath.item].isSelected = true
            headerLabelText.accept("등록한 키워드")
            applySnapshot()
        case .registeredMbti:
            fetchRegisteredMbtiCellData(indexPath: indexPath)
            registeredMbtiList.remove(at: indexPath.item)
            if registeredMbtiList.isEmpty {
                headerLabelText.accept("")
            }
            applySnapshot()
        default:
            break
        }
    }
}

extension MBTIKeywordNotificationViewController {
    
    func fetchRegisteredMbtiCellData(indexPath: IndexPath) {
        let selectedItem = dataSource.snapshot().itemIdentifiers(inSection: Section.registeredMbti)[indexPath.item]
        self.registredMbtiCellSelected.accept(MBTI(mbti: selectedItem.mbti, isSelected: selectedItem.isSelected))
    }
}
