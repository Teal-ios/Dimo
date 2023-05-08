//
//  JoinMbtiViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/06.
//

import UIKit
import RxCocoa

class JoinMbtiViewController: BaseViewController {
    
    let joinMbtiView = JoinMbtiView()
    
    private var viewModel: JoinMbtiViewModel
    
    //MARK: Input
    private lazy var input = JoinMbtiViewModel.Input(findMbtiButtonTapped: joinMbtiView.findMbtiButton.rx.tap, nextButtonTapped: joinMbtiView.nextButton.rx.tap)
    
    override func loadView() {
        view = joinMbtiView
    }
    init(viewModel: JoinMbtiViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, JoinMbtiModel>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, JoinMbtiModel>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSource()
        
    }
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
        
        
        
    }
    
    func setDataSource() {
        
        joinMbtiView.collectionView.delegate = self
        
        let cellSection1Registration = UICollectionView.CellRegistration<JoinMbtiCollectionViewCell, JoinMbtiModel> { cell, indexPath, itemIdentifier in
            
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: joinMbtiView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellSection1Registration, for: indexPath, item: itemIdentifier)
            cell.imgView.image = itemIdentifier.image ?? nil
            cell.mbtiLabel.text = itemIdentifier.mbti ?? nil
            return cell
            
        }
        let header = UICollectionView.SupplementaryRegistration<IamTheMainCharacterHeader>(elementKind: IamTheMainCharacterHeader.identifier) { supplementaryView, elementKind, indexPath in
            if indexPath.section == 0 {
                supplementaryView.label.text = "당신의 MBTI는 무엇인가요?"
            }
        }
        
        dataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: header, for: indexPath)
            return header
        })
        
        snapshot.appendSections([0])
        var section1Arr: [JoinMbtiModel] = []
        
        [JoinMbtiModel(image: UIImage(named: "E"), mbti: "외향형"),
         JoinMbtiModel(image: UIImage(named: "I"), mbti: "내향형"),
         JoinMbtiModel(image: UIImage(named: "N"), mbti: "직관형"),
         JoinMbtiModel(image: UIImage(named: "S"), mbti: "감각형"),
         JoinMbtiModel(image: UIImage(named: "T"), mbti: "사고형"),
         JoinMbtiModel(image: UIImage(named: "F"), mbti: "감정형"),
         JoinMbtiModel(image: UIImage(named: "J"), mbti: "판단형"),
         JoinMbtiModel(image: UIImage(named: "P"), mbti: "인식형")]
            .forEach { section1Arr.append($0) }
        
        snapshot.appendItems(section1Arr, toSection: 0)
        dataSource.apply(snapshot)
    }
}


extension JoinMbtiViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? JoinMbtiCollectionViewCell else { return }
        
        let section = indexPath.section
        let row = indexPath.row
        // 0일때는 처음 입력받을 때
        let item = dataSource.itemIdentifier(for: indexPath)
                        
        if (0...1).contains(indexPath.row) {
            if indexPath.row == 0 {
                switch cell.sectionSelected[indexPath.row / 2] {
                case 0:
                    cell.bgView.layer.borderColor = UIColor.purple80.cgColor
                    cell.mbtiLabel.textColor = .white100
                    cell.bgView.backgroundColor =  .black90
                    cell.sectionSelected[indexPath.row / 2] = 1
                case 1:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 0
                
                case 2:
                    cell.bgView.layer.borderColor = UIColor.purple80.cgColor
                    cell.mbtiLabel.textColor = .white100
                    cell.bgView.backgroundColor =  .black90
                    cell.sectionSelected[indexPath.row / 2] = 1
                    
                default:
                    print(indexPath.row)
                }
            } else {
                switch cell.sectionSelected[indexPath.row / 2] {
                case 0:
                    cell.bgView.layer.borderColor = UIColor.purple80.cgColor
                    cell.mbtiLabel.textColor = .white100
                    cell.bgView.backgroundColor =  .black90
                    cell.sectionSelected[indexPath.row / 2] = 2
                case 1:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 1
                case 2:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 0
                default:
                    print(indexPath.row)
                }
            }
        } else if (2...3).contains(indexPath.row) {
            if indexPath.row == 0 {
                switch cell.sectionSelected[indexPath.row / 2] {
                case 0:
                    cell.bgView.layer.borderColor = UIColor.purple80.cgColor
                    cell.mbtiLabel.textColor = .white100
                    cell.bgView.backgroundColor =  .black90
                    cell.sectionSelected[indexPath.row / 2] = 1
                case 1:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 0
                case 2:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 2
                default:
                    print(indexPath.row)
                }
            } else {
                switch cell.sectionSelected[indexPath.row / 2] {
                case 0:
                    cell.bgView.layer.borderColor = UIColor.purple80.cgColor
                    cell.mbtiLabel.textColor = .white100
                    cell.bgView.backgroundColor =  .black90
                    cell.sectionSelected[indexPath.row / 2] = 2
                case 1:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 1
                case 2:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 0
                default:
                    print(indexPath.row)
                }
            }
            
        } else if (4...5).contains(indexPath.row) {
            if indexPath.row == 0 {
                switch cell.sectionSelected[indexPath.row / 2] {
                case 0:
                    cell.bgView.layer.borderColor = UIColor.purple80.cgColor
                    cell.mbtiLabel.textColor = .white100
                    cell.bgView.backgroundColor =  .black90
                    cell.sectionSelected[indexPath.row / 2] = 1
                case 1:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 0
                case 2:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 2
                default:
                    print(indexPath.row)
                }
            } else {
                switch cell.sectionSelected[indexPath.row / 2] {
                case 0:
                    cell.bgView.layer.borderColor = UIColor.purple80.cgColor
                    cell.mbtiLabel.textColor = .white100
                    cell.bgView.backgroundColor =  .black90
                    cell.sectionSelected[indexPath.row / 2] = 2
                case 1:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 1
                case 2:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 0
                default:
                    print(indexPath.row)
                }
            }
        } else if (6...7).contains(indexPath.row) {
            if indexPath.row == 0 {
                switch cell.sectionSelected[indexPath.row / 2] {
                case 0:
                    cell.bgView.layer.borderColor = UIColor.purple80.cgColor
                    cell.mbtiLabel.textColor = .white100
                    cell.bgView.backgroundColor =  .black90
                    cell.sectionSelected[indexPath.row / 2] = 1
                case 1:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 0
                case 2:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 2
                default:
                    print(indexPath.row)
                }
            } else {
                switch cell.sectionSelected[indexPath.row / 2] {
                case 0:
                    cell.bgView.layer.borderColor = UIColor.purple80.cgColor
                    cell.mbtiLabel.textColor = .white100
                    cell.bgView.backgroundColor =  .black90
                    cell.sectionSelected[indexPath.row / 2] = 2
                case 1:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 1
                case 2:
                    cell.bgView.layer.borderColor = UIColor.black80.cgColor
                    cell.mbtiLabel.textColor = .black80
                    cell.bgView.backgroundColor = .black100
                    cell.sectionSelected[indexPath.row / 2] = 0
                default:
                    print(indexPath.row)
                }
            }
        }
    }
}
