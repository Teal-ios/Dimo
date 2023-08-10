//
//  EditMbtiViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxCocoa

final class EditMbtiViewController: BaseViewController {
    
    let selfView = EditMbtiView()
    
    private var viewModel: EditMbtiViewModel
    
    //MARK: Input
    private lazy var input = EditMbtiViewModel.Input(eButtonTapped: selfView.eView.mbtiButton.rx.tap,
                                                     iButtonTapped: selfView.iView.mbtiButton.rx.tap,
                                                     nButtonTapped: selfView.nView.mbtiButton.rx.tap,
                                                     sButtonTapped: selfView.sView.mbtiButton.rx.tap,
                                                     tButtonTapped: selfView.tView.mbtiButton.rx.tap,
                                                     fButtonTapped: selfView.fView.mbtiButton.rx.tap,
                                                     jButtonTapped: selfView.jView.mbtiButton.rx.tap,
                                                     pButtonTapped: selfView.pView.mbtiButton.rx.tap)
    
    override func loadView() {
        self.view = selfView
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
                self?.selfView.eView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.eView.mbtiLabel.textColor = .black5
                self?.selfView.eView.backgroundColor = .black90
                cellSelectArr[0] = true

            } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
                self?.selfView.eView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.eView.mbtiLabel.textColor = .black80
                self?.selfView.eView.backgroundColor = .black100
                cellSelectArr[0] = false
            } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
                self?.selfView.eView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.eView.mbtiLabel.textColor = .black5
                self?.selfView.eView.backgroundColor = .black90
                
                self?.selfView.iView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.iView.mbtiLabel.textColor = .black80
                self?.selfView.iView.backgroundColor = .black100
                cellSelectArr[0] = true
                cellSelectArr[1] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.iButtonTapped.bind { [weak self] _ in
            if cellSelectArr[0] == false && cellSelectArr[1] == false {
                self?.selfView.iView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.iView.mbtiLabel.textColor = .black5
                self?.selfView.iView.backgroundColor = .black90
                cellSelectArr[1] = true

            } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
                self?.selfView.eView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.eView.mbtiLabel.textColor = .black80
                self?.selfView.eView.backgroundColor = .black100
                
                self?.selfView.iView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.iView.mbtiLabel.textColor = .black5
                self?.selfView.iView.backgroundColor = .black90
                cellSelectArr[0] = false
                cellSelectArr[1] = true
            } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
                self?.selfView.iView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.iView.mbtiLabel.textColor = .black80
                self?.selfView.iView.backgroundColor = .black100
                cellSelectArr[1] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.nButtonTapped.bind { [weak self] _ in
            if cellSelectArr[2] == false && cellSelectArr[3] == false {
                self?.selfView.nView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.nView.mbtiLabel.textColor = .black5
                self?.selfView.nView.backgroundColor = .black90
                cellSelectArr[2] = true

            } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
                self?.selfView.nView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.nView.mbtiLabel.textColor = .black80
                self?.selfView.nView.backgroundColor = .black100
                
                cellSelectArr[2] = false
            } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
                self?.selfView.nView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.nView.mbtiLabel.textColor = .black5
                self?.selfView.nView.backgroundColor = .black90
                
                self?.selfView.sView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.sView.mbtiLabel.textColor = .black80
                self?.selfView.sView.backgroundColor = .black100
                cellSelectArr[2] = true
                cellSelectArr[3] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.sButtonTapped.bind { [weak self] _ in
            if cellSelectArr[2] == false && cellSelectArr[3] == false {
                self?.selfView.sView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.sView.mbtiLabel.textColor = .black5
                self?.selfView.sView.backgroundColor = .black90
                cellSelectArr[3] = true

            } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
                self?.selfView.nView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.nView.mbtiLabel.textColor = .black80
                self?.selfView.nView.backgroundColor = .black100
                
                self?.selfView.sView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.sView.mbtiLabel.textColor = .black5
                self?.selfView.sView.backgroundColor = .black90
                cellSelectArr[2] = false
                cellSelectArr[3] = true
            } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
                self?.selfView.sView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.sView.mbtiLabel.textColor = .black80
                self?.selfView.sView.backgroundColor = .black100
                cellSelectArr[3] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.tButtonTapped.bind { [weak self] _ in
            if cellSelectArr[4] == false && cellSelectArr[5] == false {
                self?.selfView.tView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.tView.mbtiLabel.textColor = .black5
                self?.selfView.tView.backgroundColor = .black90
                cellSelectArr[4] = true

            } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
                self?.selfView.tView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.tView.mbtiLabel.textColor = .black80
                self?.selfView.tView.backgroundColor = .black100
                
                cellSelectArr[4] = false
            } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
                self?.selfView.tView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.tView.mbtiLabel.textColor = .black5
                self?.selfView.tView.backgroundColor = .black90
                
                self?.selfView.fView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.fView.mbtiLabel.textColor = .black80
                self?.selfView.fView.backgroundColor = .black100
                cellSelectArr[4] = true
                cellSelectArr[5] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.fButtonTapped.bind { [weak self] _ in
            if cellSelectArr[4] == false && cellSelectArr[5] == false {
                self?.selfView.fView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.fView.mbtiLabel.textColor = .black5
                self?.selfView.fView.backgroundColor = .black90
                cellSelectArr[5] = true

            } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
                self?.selfView.tView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.tView.mbtiLabel.textColor = .black80
                self?.selfView.tView.backgroundColor = .black100
                
                self?.selfView.fView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.fView.mbtiLabel.textColor = .black5
                self?.selfView.fView.backgroundColor = .black90
                cellSelectArr[4] = false
                cellSelectArr[5] = true
            } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
                self?.selfView.fView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.fView.mbtiLabel.textColor = .black80
                self?.selfView.fView.backgroundColor = .black100
                cellSelectArr[5] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.jButtonTapped.bind { [weak self] _ in
            if cellSelectArr[6] == false && cellSelectArr[7] == false {
                self?.selfView.jView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.jView.mbtiLabel.textColor = .black5
                self?.selfView.jView.backgroundColor = .black90
                cellSelectArr[6] = true

            } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
                self?.selfView.jView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.jView.mbtiLabel.textColor = .black80
                self?.selfView.jView.backgroundColor = .black100
                
                cellSelectArr[6] = false
            } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
                self?.selfView.jView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.jView.mbtiLabel.textColor = .black5
                self?.selfView.jView.backgroundColor = .black90
                
                self?.selfView.pView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.pView.mbtiLabel.textColor = .black80
                self?.selfView.pView.backgroundColor = .black100
                cellSelectArr[6] = true
                cellSelectArr[7] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.pButtonTapped.bind { [weak self] _ in
            if cellSelectArr[6] == false && cellSelectArr[7] == false {
                self?.selfView.pView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.pView.mbtiLabel.textColor = .black5
                self?.selfView.pView.backgroundColor = .black90
                cellSelectArr[7] = true

            } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
                self?.selfView.jView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.jView.mbtiLabel.textColor = .black80
                self?.selfView.jView.backgroundColor = .black100
                
                self?.selfView.pView.layer.borderColor = UIColor.purple80.cgColor
                self?.selfView.pView.mbtiLabel.textColor = .black5
                self?.selfView.pView.backgroundColor = .black90
                cellSelectArr[6] = false
                cellSelectArr[7] = true
            } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
                self?.selfView.pView.layer.borderColor = UIColor.black80.cgColor
                self?.selfView.pView.mbtiLabel.textColor = .black80
                self?.selfView.pView.backgroundColor = .black100
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
                    self.selfView.checkMbtiChangeButtonValidation(true)
                } else {
                    self.selfView.checkMbtiChangeButtonValidation(false)
                }
                
                print(mbti)
                
            }
            .disposed(by: disposeBag)
    }
}
