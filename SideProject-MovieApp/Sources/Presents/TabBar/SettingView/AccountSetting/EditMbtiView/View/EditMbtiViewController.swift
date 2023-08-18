//
//  EditMbtiViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class EditMbtiViewController: BaseViewController {
    
    let editMbtiView = EditMbtiView()
    
    private var viewModel: EditMbtiViewModel
    
    private var isFirstTime: Bool = true
    
    //MARK: Input
    private lazy var input = EditMbtiViewModel.Input(eButtonTapped: editMbtiView.eView.mbtiButton.rx.tap,
                                                     iButtonTapped: editMbtiView.iView.mbtiButton.rx.tap,
                                                     nButtonTapped: editMbtiView.nView.mbtiButton.rx.tap,
                                                     sButtonTapped: editMbtiView.sView.mbtiButton.rx.tap,
                                                     tButtonTapped: editMbtiView.tView.mbtiButton.rx.tap,
                                                     fButtonTapped: editMbtiView.fView.mbtiButton.rx.tap,
                                                     jButtonTapped: editMbtiView.jView.mbtiButton.rx.tap,
                                                     pButtonTapped: editMbtiView.pView.mbtiButton.rx.tap,
                                                     changeButtonTapped: editMbtiView.mbtiChangeButton.rx.tap)
    
    override func loadView() {
        self.view = editMbtiView
    }
    
    init(viewModel: EditMbtiViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    private func setCurrentMbti() {
        guard let currentMbti = UserDefaultManager.mbti else { return }
        
        for mbti in currentMbti {
            switch mbti.uppercased() {
            case "E":
                editMbtiView.eView.layer.borderColor = UIColor.purple80.cgColor
                editMbtiView.eView.imgView.image = UIImage(named: "E_White")
                editMbtiView.eView.mbtiLabel.textColor = .black5
                editMbtiView.eView.backgroundColor = .black90
            case "I":
                editMbtiView.iView.layer.borderColor = UIColor.purple80.cgColor
                editMbtiView.iView.imgView.image = UIImage(named: "I_White")
                editMbtiView.iView.mbtiLabel.textColor = .black5
                editMbtiView.iView.backgroundColor = .black90
            case "N":
                editMbtiView.nView.layer.borderColor = UIColor.purple80.cgColor
                editMbtiView.nView.imgView.image = UIImage(named: "N_White")
                editMbtiView.nView.mbtiLabel.textColor = .black5
                editMbtiView.nView.backgroundColor = .black90
            case "S":
                editMbtiView.sView.layer.borderColor = UIColor.purple80.cgColor
                editMbtiView.sView.imgView.image = UIImage(named: "S_White")
                editMbtiView.sView.mbtiLabel.textColor = .black5
                editMbtiView.sView.backgroundColor = .black90
            case "T":
                editMbtiView.tView.layer.borderColor = UIColor.purple80.cgColor
                editMbtiView.tView.imgView.image = UIImage(named: "T_White")
                editMbtiView.tView.mbtiLabel.textColor = .black5
                editMbtiView.tView.backgroundColor = .black90
            case "F":
                editMbtiView.fView.layer.borderColor = UIColor.purple80.cgColor
                editMbtiView.fView.imgView.image = UIImage(named: "F_White")
                editMbtiView.fView.mbtiLabel.textColor = .black5
                editMbtiView.fView.backgroundColor = .black90
            case "J":
                editMbtiView.jView.layer.borderColor = UIColor.purple80.cgColor
                editMbtiView.jView.imgView.image = UIImage(named: "J_White")
                editMbtiView.jView.mbtiLabel.textColor = .black5
                editMbtiView.jView.backgroundColor = .black90
            case "P":
                editMbtiView.pView.layer.borderColor = UIColor.purple80.cgColor
                editMbtiView.pView.imgView.image = UIImage(named: "P_White")
                editMbtiView.pView.mbtiLabel.textColor = .black5
                editMbtiView.pView.backgroundColor = .black90
            default:
                break
            }
        }
    }
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
               
        var cellSelectArr: [Bool] = [false, false, false, false, false, false, false, false] //E I N S T F J P 순서
        
        guard let currentMbti = UserDefaultManager.mbti else { return }
        
        for mbti in currentMbti {
            switch mbti.uppercased() {
            case "E":
                editMbtiView.showEButtonState(isSelected: true)
                cellSelectArr[0] = true
            case "I":
                editMbtiView.showIButtonState(isSelected: true)
                cellSelectArr[1] = true
            case "N":
                editMbtiView.showNButtonState(isSelected: true)
                cellSelectArr[2] = true
            case "S":
                editMbtiView.showSButtonState(isSelected: true)
                cellSelectArr[3] = true
            case "T":
                editMbtiView.showTButtonState(isSelected: true)
                cellSelectArr[4] = true
            case "F":
                editMbtiView.showFButtonState(isSelected: true)
                cellSelectArr[5] = true
            case "J":
                editMbtiView.showJButtonState(isSelected: true)
                cellSelectArr[6] = true
            case "P":
                editMbtiView.showPButtonState(isSelected: true)
                cellSelectArr[7] = true
            default:
                break
            }
        }

        output.eButtonTapped.bind { [weak self] _ in
            if cellSelectArr[0] == false && cellSelectArr[1] == false {
                self?.editMbtiView.showEButtonState(isSelected: true)
                cellSelectArr[0] = true

            } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
                self?.editMbtiView.showEButtonState(isSelected: false)
                cellSelectArr[0] = false
            } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
                self?.editMbtiView.showEButtonState(isSelected: true)
                self?.editMbtiView.showIButtonState(isSelected: false)
                cellSelectArr[0] = true
                cellSelectArr[1] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.iButtonTapped.bind { [weak self] _ in
            if cellSelectArr[0] == false && cellSelectArr[1] == false {
                self?.editMbtiView.showIButtonState(isSelected: true)
                cellSelectArr[1] = true

            } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
                self?.editMbtiView.showEButtonState(isSelected: false)
                self?.editMbtiView.showIButtonState(isSelected: true)
                cellSelectArr[0] = false
                cellSelectArr[1] = true
            } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
                self?.editMbtiView.showIButtonState(isSelected: false)
                cellSelectArr[1] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.nButtonTapped.bind { [weak self] _ in
            if cellSelectArr[2] == false && cellSelectArr[3] == false {
                self?.editMbtiView.showNButtonState(isSelected: true)
                cellSelectArr[2] = true
            } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
                self?.editMbtiView.showNButtonState(isSelected: false)
                cellSelectArr[2] = false
            } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
                self?.editMbtiView.showNButtonState(isSelected: true)
                self?.editMbtiView.showSButtonState(isSelected: false)
                cellSelectArr[2] = true
                cellSelectArr[3] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.sButtonTapped.bind { [weak self] _ in
            if cellSelectArr[2] == false && cellSelectArr[3] == false {
                self?.editMbtiView.showSButtonState(isSelected: true)
                cellSelectArr[3] = true
            } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
                self?.editMbtiView.showNButtonState(isSelected: false)
                self?.editMbtiView.showSButtonState(isSelected: true)
                cellSelectArr[2] = false
                cellSelectArr[3] = true
            } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
                self?.editMbtiView.showSButtonState(isSelected: false)
                cellSelectArr[3] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.tButtonTapped.bind { [weak self] _ in
            if cellSelectArr[4] == false && cellSelectArr[5] == false {
                self?.editMbtiView.showTButtonState(isSelected: true)
                cellSelectArr[4] = true

            } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
                self?.editMbtiView.showTButtonState(isSelected: false)
                cellSelectArr[4] = false
            } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
                self?.editMbtiView.showTButtonState(isSelected: true)
                self?.editMbtiView.showFButtonState(isSelected: false)
                cellSelectArr[4] = true
                cellSelectArr[5] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.fButtonTapped.bind { [weak self] _ in
            if cellSelectArr[4] == false && cellSelectArr[5] == false {
                self?.editMbtiView.showFButtonState(isSelected: true)
                cellSelectArr[5] = true

            } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
                self?.editMbtiView.showTButtonState(isSelected: false)
                self?.editMbtiView.showFButtonState(isSelected: true)
                cellSelectArr[4] = false
                cellSelectArr[5] = true
            } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
                self?.editMbtiView.showFButtonState(isSelected: false)
                cellSelectArr[5] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.jButtonTapped.bind { [weak self] _ in
            if cellSelectArr[6] == false && cellSelectArr[7] == false {
                self?.editMbtiView.showJButtonState(isSelected: true)
                cellSelectArr[6] = true

            } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
                self?.editMbtiView.showJButtonState(isSelected: false)
                cellSelectArr[6] = false
            } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
                self?.editMbtiView.showJButtonState(isSelected: true)
                self?.editMbtiView.showPButtonState(isSelected: false)
                cellSelectArr[6] = true
                cellSelectArr[7] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.pButtonTapped.bind { [weak self] _ in
            if cellSelectArr[6] == false && cellSelectArr[7] == false {
                self?.editMbtiView.showPButtonState(isSelected: true)
                cellSelectArr[7] = true

            } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
                self?.editMbtiView.showJButtonState(isSelected: false)
                self?.editMbtiView.showPButtonState(isSelected: true)
                cellSelectArr[6] = false
                cellSelectArr[7] = true
            } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
                self?.editMbtiView.showPButtonState(isSelected: false)
                cellSelectArr[7] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.isValidMbti
            .bind { [weak self] mbti in
                guard let self else { return }
                guard let EisSelected = mbti["E"],
                      let IisSelected = mbti["I"],
                      let NisSelected = mbti["N"],
                      let SisSelected = mbti["S"],
                      let TisSelected = mbti["T"],
                      let FisSelected = mbti["F"],
                      let JisSelected = mbti["J"],
                      let PisSelected = mbti["P"] else { return }
                
                if (EisSelected || IisSelected) && (NisSelected || SisSelected) && (TisSelected || FisSelected) && (JisSelected || PisSelected) == true && self.isFirstTime == false {
                    self.editMbtiView.checkMbtiChangeButtonValidation(true)
                } else {
                    self.editMbtiView.checkMbtiChangeButtonValidation(false)
                }
                self.isFirstTime = false
                print(mbti)
            }
            .disposed(by: disposeBag)
        
        output.isChanged
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { (vc, isChanged) in
                if isChanged {
                    vc.editMbtiView.makeToast("변경을 완료했어요", style: ToastStyle.dimo)
                    vc.editMbtiView.disableChangeButton()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
