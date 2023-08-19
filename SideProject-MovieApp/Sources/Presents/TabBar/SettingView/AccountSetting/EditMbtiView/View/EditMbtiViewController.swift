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
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
               
        var cellSelectArr: [Bool] = [false, false, false, false, false, false, false, false] //E I N S T F J P 순서
        
        guard let currentMbti = viewModel.userMbti.value else { return }
        
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
        
        output.mbtiChangedDate
            .withUnretained(self)
            .bind { (vc, mbtiChangedDate) in
                let mbtiChangedDate = Date.dateToString(from: mbtiChangedDate)
                guard let mbtiChangedDate = mbtiChangedDate else {
                    vc.editMbtiView.lastChangeDayLabel.text = "마지막 변경일: 변경 기록이 없어요"
                    return
                }
                
                vc.editMbtiView.lastChangeDayLabel.text = "마지막 변경일: \(mbtiChangedDate)"
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
                
                if (EisSelected || IisSelected) && (NisSelected || SisSelected) && (TisSelected || FisSelected) && (JisSelected || PisSelected) == true && !(currentMbti == self.viewModel.selectedMbti.value) {
                    self.editMbtiView.checkMbtiChangeButtonValidation(true)
                } else {
                    self.editMbtiView.checkMbtiChangeButtonValidation(false)
                }
                print(mbti)
            }
            .disposed(by: disposeBag)
        
        output.isMbtiChangedOverOneMonth
            .withUnretained(self)
            .bind { (vc, isMbtiChangedOverOneMonth) in
                guard let isOverOneMonth = isMbtiChangedOverOneMonth else { return }
                if isOverOneMonth {
                    vc.editMbtiView.mbtiChangeButton.isHidden = false
                    vc.editMbtiView.findMbtiButton.isHidden = false
                } else {
                    vc.editMbtiView.findMbtiButton.isHidden = true
                    vc.editMbtiView.mbtiChangeButton.isHidden = true
                    vc.editMbtiView.disableMbtiButton()
                }
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
