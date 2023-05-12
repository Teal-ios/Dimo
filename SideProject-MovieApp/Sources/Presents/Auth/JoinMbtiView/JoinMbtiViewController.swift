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
    
    private lazy var input = JoinMbtiViewModel.Input(findMbtiButtonTapped: joinMbtiView.findMbtiButton.rx.tap, nextButtonTapped: joinMbtiView.nextButton.rx.tap, eButtonTapped: joinMbtiView.eView.mbtiButton.rx.tap, iButtonTapped: joinMbtiView.iView.mbtiButton.rx.tap, nButtonTapped: joinMbtiView.nView.mbtiButton.rx.tap, sButtonTapped: joinMbtiView.sView.mbtiButton.rx.tap, tButtonTapped: joinMbtiView.tView.mbtiButton.rx.tap, fButtonTapped: joinMbtiView.fView.mbtiButton.rx.tap, jButtonTapped: joinMbtiView.jView.mbtiButton.rx.tap, pButtonTapped: joinMbtiView.pView.mbtiButton.rx.tap)
    
    override func loadView() {
        view = joinMbtiView
    }
    init(viewModel: JoinMbtiViewModel) {
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
                self?.joinMbtiView.eView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.eView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.eView.backgroundColor = .black90
                cellSelectArr[0] = true

            } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
                self?.joinMbtiView.eView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.eView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.eView.backgroundColor = .black100
                cellSelectArr[0] = false
            } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
                self?.joinMbtiView.eView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.eView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.eView.backgroundColor = .black90
                
                self?.joinMbtiView.iView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.iView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.iView.backgroundColor = .black100
                cellSelectArr[0] = true
                cellSelectArr[1] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.iButtonTapped.bind { [weak self] _ in
            if cellSelectArr[0] == false && cellSelectArr[1] == false {
                self?.joinMbtiView.iView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.iView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.iView.backgroundColor = .black90
                cellSelectArr[1] = true

            } else if cellSelectArr[0] == true && cellSelectArr[1] == false {
                self?.joinMbtiView.eView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.eView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.eView.backgroundColor = .black100
                
                self?.joinMbtiView.iView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.iView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.iView.backgroundColor = .black90
                cellSelectArr[0] = false
                cellSelectArr[1] = true
            } else if cellSelectArr[0] == false && cellSelectArr[1] == true {
                self?.joinMbtiView.iView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.iView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.iView.backgroundColor = .black100
                cellSelectArr[1] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.nButtonTapped.bind { [weak self] _ in
            if cellSelectArr[2] == false && cellSelectArr[3] == false {
                self?.joinMbtiView.nView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.nView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.nView.backgroundColor = .black90
                cellSelectArr[2] = true

            } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
                self?.joinMbtiView.nView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.nView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.nView.backgroundColor = .black100
                
                cellSelectArr[2] = false
            } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
                self?.joinMbtiView.nView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.nView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.nView.backgroundColor = .black90
                
                self?.joinMbtiView.sView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.sView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.sView.backgroundColor = .black100
                cellSelectArr[2] = true
                cellSelectArr[3] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.sButtonTapped.bind { [weak self] _ in
            if cellSelectArr[2] == false && cellSelectArr[3] == false {
                self?.joinMbtiView.sView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.sView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.sView.backgroundColor = .black90
                cellSelectArr[3] = true

            } else if cellSelectArr[2] == true && cellSelectArr[3] == false {
                self?.joinMbtiView.nView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.nView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.nView.backgroundColor = .black100
                
                self?.joinMbtiView.sView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.sView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.sView.backgroundColor = .black90
                cellSelectArr[2] = false
                cellSelectArr[3] = true
            } else if cellSelectArr[2] == false && cellSelectArr[3] == true {
                self?.joinMbtiView.sView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.sView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.sView.backgroundColor = .black100
                cellSelectArr[3] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.tButtonTapped.bind { [weak self] _ in
            if cellSelectArr[4] == false && cellSelectArr[5] == false {
                self?.joinMbtiView.tView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.tView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.tView.backgroundColor = .black90
                cellSelectArr[4] = true

            } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
                self?.joinMbtiView.tView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.tView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.tView.backgroundColor = .black100
                
                cellSelectArr[4] = false
            } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
                self?.joinMbtiView.tView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.tView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.tView.backgroundColor = .black90
                
                self?.joinMbtiView.fView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.fView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.fView.backgroundColor = .black100
                cellSelectArr[4] = true
                cellSelectArr[5] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.fButtonTapped.bind { [weak self] _ in
            if cellSelectArr[4] == false && cellSelectArr[5] == false {
                self?.joinMbtiView.fView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.fView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.fView.backgroundColor = .black90
                cellSelectArr[5] = true

            } else if cellSelectArr[4] == true && cellSelectArr[5] == false {
                self?.joinMbtiView.tView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.tView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.tView.backgroundColor = .black100
                
                self?.joinMbtiView.fView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.fView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.fView.backgroundColor = .black90
                cellSelectArr[4] = false
                cellSelectArr[5] = true
            } else if cellSelectArr[4] == false && cellSelectArr[5] == true {
                self?.joinMbtiView.fView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.fView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.fView.backgroundColor = .black100
                cellSelectArr[5] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.jButtonTapped.bind { [weak self] _ in
            if cellSelectArr[6] == false && cellSelectArr[7] == false {
                self?.joinMbtiView.jView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.jView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.jView.backgroundColor = .black90
                cellSelectArr[6] = true

            } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
                self?.joinMbtiView.jView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.jView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.jView.backgroundColor = .black100
                
                cellSelectArr[6] = false
            } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
                self?.joinMbtiView.jView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.jView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.jView.backgroundColor = .black90
                
                self?.joinMbtiView.pView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.pView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.pView.backgroundColor = .black100
                cellSelectArr[6] = true
                cellSelectArr[7] = false
            }
        }
        .disposed(by: disposeBag)
        
        output.pButtonTapped.bind { [weak self] _ in
            if cellSelectArr[6] == false && cellSelectArr[7] == false {
                self?.joinMbtiView.pView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.pView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.pView.backgroundColor = .black90
                cellSelectArr[7] = true

            } else if cellSelectArr[6] == true && cellSelectArr[7] == false {
                self?.joinMbtiView.jView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.jView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.jView.backgroundColor = .black100
                
                self?.joinMbtiView.pView.layer.borderColor = UIColor.purple80.cgColor
                self?.joinMbtiView.pView.mbtiLabel.textColor = .white100
                self?.joinMbtiView.pView.backgroundColor = .black90
                cellSelectArr[6] = false
                cellSelectArr[7] = true
            } else if cellSelectArr[6] == false && cellSelectArr[7] == true {
                self?.joinMbtiView.pView.layer.borderColor = UIColor.black80.cgColor
                self?.joinMbtiView.pView.mbtiLabel.textColor = .black80
                self?.joinMbtiView.pView.backgroundColor = .black100
                cellSelectArr[7] = false
            }
        }
        .disposed(by: disposeBag)
    }
}
