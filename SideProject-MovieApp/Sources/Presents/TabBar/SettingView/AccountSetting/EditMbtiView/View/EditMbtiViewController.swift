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
               
        var cellSelectArr: [Bool] = [false, false, false, false, false, false, false, false]

        output.eButtonTapped.bind { [weak self] _ in
            if cellSelectArr[0] == false && cellSelectArr[1] == false {
                self?.editMbtiView.eView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.eView.imgView.image = UIImage(named: "E_White")
                self?.editMbtiView.eView.mbtiLabel.textColor = .black5
                self?.editMbtiView.eView.backgroundColor = .black90
                cellSelectArr[0] = true

            } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
                self?.editMbtiView.eView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.eView.imgView.image = UIImage(named: "E_Gray")
                self?.editMbtiView.eView.mbtiLabel.textColor = .black80
                self?.editMbtiView.eView.backgroundColor = .black100
                cellSelectArr[0] = false
            } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
                self?.editMbtiView.eView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.eView.mbtiLabel.textColor = .black5
                self?.editMbtiView.eView.backgroundColor = .black90
                self?.editMbtiView.eView.imgView.image = UIImage(named: "E_White")
                
                self?.editMbtiView.iView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.iView.imgView.image = UIImage(named: "I_Gray")
                self?.editMbtiView.iView.mbtiLabel.textColor = .black80
                self?.editMbtiView.iView.backgroundColor = .black100
                cellSelectArr[0] = true
                cellSelectArr[1] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.iButtonTapped.bind { [weak self] _ in
            if cellSelectArr[0] == false && cellSelectArr[1] == false {
                self?.editMbtiView.iView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.iView.imgView.image = UIImage(named: "I_White")
                self?.editMbtiView.iView.mbtiLabel.textColor = .black5
                self?.editMbtiView.iView.backgroundColor = .black90
                cellSelectArr[1] = true

            } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
                self?.editMbtiView.eView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.eView.imgView.image = UIImage(named: "E_Gray")
                self?.editMbtiView.eView.mbtiLabel.textColor = .black80
                self?.editMbtiView.eView.backgroundColor = .black100
                
                self?.editMbtiView.iView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.iView.imgView.image = UIImage(named: "I_White")
                self?.editMbtiView.iView.mbtiLabel.textColor = .black5
                self?.editMbtiView.iView.backgroundColor = .black90
                cellSelectArr[0] = false
                cellSelectArr[1] = true
            } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
                self?.editMbtiView.iView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.iView.imgView.image = UIImage(named: "I_Gray")
                self?.editMbtiView.iView.mbtiLabel.textColor = .black80
                self?.editMbtiView.iView.backgroundColor = .black100
                cellSelectArr[1] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.nButtonTapped.bind { [weak self] _ in
            if cellSelectArr[2] == false && cellSelectArr[3] == false {
                self?.editMbtiView.nView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.nView.imgView.image = UIImage(named: "N_White")
                self?.editMbtiView.nView.mbtiLabel.textColor = .black5
                self?.editMbtiView.nView.backgroundColor = .black90
                cellSelectArr[2] = true

            } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
                self?.editMbtiView.nView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.nView.imgView.image = UIImage(named: "N_Gray")
                self?.editMbtiView.nView.mbtiLabel.textColor = .black80
                self?.editMbtiView.nView.backgroundColor = .black100
                
                cellSelectArr[2] = false
            } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
                self?.editMbtiView.nView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.nView.imgView.image = UIImage(named: "N_White")
                self?.editMbtiView.nView.mbtiLabel.textColor = .black5
                self?.editMbtiView.nView.backgroundColor = .black90
                
                self?.editMbtiView.sView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.sView.imgView.image = UIImage(named: "S_Gray")
                self?.editMbtiView.sView.mbtiLabel.textColor = .black80
                self?.editMbtiView.sView.backgroundColor = .black100
                cellSelectArr[2] = true
                cellSelectArr[3] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.sButtonTapped.bind { [weak self] _ in
            if cellSelectArr[2] == false && cellSelectArr[3] == false {
                self?.editMbtiView.sView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.sView.imgView.image = UIImage(named: "S_White")
                self?.editMbtiView.sView.mbtiLabel.textColor = .black5
                self?.editMbtiView.sView.backgroundColor = .black90
                cellSelectArr[3] = true

            } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
                self?.editMbtiView.nView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.nView.imgView.image = UIImage(named: "N_Gray")
                self?.editMbtiView.nView.mbtiLabel.textColor = .black80
                self?.editMbtiView.nView.backgroundColor = .black100
                
                self?.editMbtiView.sView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.sView.imgView.image = UIImage(named: "S_White")
                self?.editMbtiView.sView.mbtiLabel.textColor = .black5
                self?.editMbtiView.sView.backgroundColor = .black90
                cellSelectArr[2] = false
                cellSelectArr[3] = true
            } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
                self?.editMbtiView.sView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.sView.imgView.image = UIImage(named: "S_Gray")
                self?.editMbtiView.sView.mbtiLabel.textColor = .black80
                self?.editMbtiView.sView.backgroundColor = .black100
                cellSelectArr[3] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.tButtonTapped.bind { [weak self] _ in
            if cellSelectArr[4] == false && cellSelectArr[5] == false {
                self?.editMbtiView.tView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.tView.imgView.image = UIImage(named: "T_White")
                self?.editMbtiView.tView.mbtiLabel.textColor = .black5
                self?.editMbtiView.tView.backgroundColor = .black90
                cellSelectArr[4] = true

            } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
                self?.editMbtiView.tView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.tView.imgView.image = UIImage(named: "T_Gray")
                self?.editMbtiView.tView.mbtiLabel.textColor = .black80
                self?.editMbtiView.tView.backgroundColor = .black100
                
                cellSelectArr[4] = false
            } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
                self?.editMbtiView.tView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.tView.imgView.image = UIImage(named: "T_White")
                self?.editMbtiView.tView.mbtiLabel.textColor = .black5
                self?.editMbtiView.tView.backgroundColor = .black90
                
                self?.editMbtiView.fView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.fView.imgView.image = UIImage(named: "F_Gray")
                self?.editMbtiView.fView.mbtiLabel.textColor = .black80
                self?.editMbtiView.fView.backgroundColor = .black100
                cellSelectArr[4] = true
                cellSelectArr[5] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.fButtonTapped.bind { [weak self] _ in
            if cellSelectArr[4] == false && cellSelectArr[5] == false {
                self?.editMbtiView.fView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.fView.imgView.image = UIImage(named: "F_White")
                self?.editMbtiView.fView.mbtiLabel.textColor = .black5
                self?.editMbtiView.fView.backgroundColor = .black90
                cellSelectArr[5] = true

            } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
                self?.editMbtiView.tView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.tView.imgView.image = UIImage(named: "T_Gray")
                self?.editMbtiView.tView.mbtiLabel.textColor = .black80
                self?.editMbtiView.tView.backgroundColor = .black100
                
                self?.editMbtiView.fView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.fView.imgView.image = UIImage(named: "F_White")
                self?.editMbtiView.fView.mbtiLabel.textColor = .black5
                self?.editMbtiView.fView.backgroundColor = .black90
                cellSelectArr[4] = false
                cellSelectArr[5] = true
            } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
                self?.editMbtiView.fView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.fView.imgView.image = UIImage(named: "F_Gray")
                self?.editMbtiView.fView.mbtiLabel.textColor = .black80
                self?.editMbtiView.fView.backgroundColor = .black100
                cellSelectArr[5] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.jButtonTapped.bind { [weak self] _ in
            if cellSelectArr[6] == false && cellSelectArr[7] == false {
                self?.editMbtiView.jView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.jView.imgView.image = UIImage(named: "J_White")
                self?.editMbtiView.jView.mbtiLabel.textColor = .black5
                self?.editMbtiView.jView.backgroundColor = .black90
                cellSelectArr[6] = true

            } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
                self?.editMbtiView.jView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.jView.mbtiLabel.textColor = .black80
                self?.editMbtiView.jView.backgroundColor = .black100
                self?.editMbtiView.jView.imgView.image = UIImage(named: "J_Gray")
                
                cellSelectArr[6] = false
            } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
                self?.editMbtiView.jView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.jView.imgView.image = UIImage(named: "J_White")
                self?.editMbtiView.jView.mbtiLabel.textColor = .black5
                self?.editMbtiView.jView.backgroundColor = .black90
                
                self?.editMbtiView.pView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.pView.imgView.image = UIImage(named: "P_Gray")
                self?.editMbtiView.pView.mbtiLabel.textColor = .black80
                self?.editMbtiView.pView.backgroundColor = .black100
                cellSelectArr[6] = true
                cellSelectArr[7] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.pButtonTapped.bind { [weak self] _ in
            if cellSelectArr[6] == false && cellSelectArr[7] == false {
                self?.editMbtiView.pView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.pView.imgView.image = UIImage(named: "P_White")
                self?.editMbtiView.pView.mbtiLabel.textColor = .black5
                self?.editMbtiView.pView.backgroundColor = .black90
                cellSelectArr[7] = true

            } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
                self?.editMbtiView.jView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.jView.imgView.image = UIImage(named: "J_Gray")
                self?.editMbtiView.jView.mbtiLabel.textColor = .black80
                self?.editMbtiView.jView.backgroundColor = .black100
                
                self?.editMbtiView.pView.layer.borderColor = UIColor.purple80.cgColor
                self?.editMbtiView.pView.imgView.image = UIImage(named: "P_White")
                self?.editMbtiView.pView.mbtiLabel.textColor = .black5
                self?.editMbtiView.pView.backgroundColor = .black90
                cellSelectArr[6] = false
                cellSelectArr[7] = true
            } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
                self?.editMbtiView.pView.layer.borderColor = UIColor.black80.cgColor
                self?.editMbtiView.pView.imgView.image = UIImage(named: "P_Gray")
                self?.editMbtiView.pView.mbtiLabel.textColor = .black80
                self?.editMbtiView.pView.backgroundColor = .black100
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
                
                if (EisSelected || IisSelected) && (NisSelected || SisSelected) && (TisSelected || FisSelected) && (JisSelected || PisSelected) == true {
                    self.editMbtiView.checkMbtiChangeButtonValidation(true)
                } else {
                    self.editMbtiView.checkMbtiChangeButtonValidation(false)
                }
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
