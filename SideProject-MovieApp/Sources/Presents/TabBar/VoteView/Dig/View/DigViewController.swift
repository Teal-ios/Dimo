//
//  DigViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/04.
//

import UIKit
import RxSwift
import RxCocoa

final class DigViewController: BaseViewController {
    
    let selfView = DigView()
    
    private var viewModel: DigViewModel
    
    init(viewModel: DigViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = selfView
    }
    
    var cellSelectArr: [Bool] = [false, false, false, false, false, false, false, false]
    var mbtiString: String = ""
    var mbtiArray = PublishRelay<[Bool]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupBinding() {
        let input = DigViewModel.Input(nextButtonTap: self.selfView.nextButton.rx.tap, eButtonTapped: self.selfView.eView.mbtiButton.rx.tap, iButtonTapped: self.selfView.iView.mbtiButton.rx.tap, nButtonTapped: self.selfView.nView.mbtiButton.rx.tap, sButtonTapped: self.selfView.sView.mbtiButton.rx.tap, tButtonTapped: self.selfView.tView.mbtiButton.rx.tap, fButtonTapped: self.selfView.fView.mbtiButton.rx.tap, jButtonTapped: self.selfView.jView.mbtiButton.rx.tap, pButtonTapped: self.selfView.pView.mbtiButton.rx.tap, mbtiInfo: self.mbtiArray)
        
        let output = viewModel.transform(input: input)
        
        output.characterInfo
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, characterInfo in
                print(characterInfo, "렛츠 디그 뷰")
                vc.selfView.configureUpdateCharacterInfo(with: characterInfo)
            }
            .disposed(by: disposeBag)
        
        output.eButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                if vc.cellSelectArr[0] == false && vc.cellSelectArr[1] == false {
                    
                    vc.selfView.updateEView(select: true)
                    vc.cellSelectArr[0] = true
                    
                } else if vc.cellSelectArr[0] == true && vc.cellSelectArr[1] == false {
                    
                    vc.selfView.updateEView(select: false)
                    vc.cellSelectArr[0] = false
                    
                } else if vc.cellSelectArr [0] == false && vc.cellSelectArr[1] == true {
                    
                    vc.selfView.updateEView(select: true)
                    vc.selfView.updateIView(select: false)
                    vc.cellSelectArr[0] = true
                    vc.cellSelectArr[1] = false
                }
                vc.mbtiArray.accept(vc.cellSelectArr)
            }
            .disposed(by: disposeBag)
        
        output.iButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                if vc.cellSelectArr[0] == false && vc.cellSelectArr[1] == false {
                    
                    vc.selfView.updateIView(select: true)
                    vc.cellSelectArr[1] = true
                    
                } else if vc.cellSelectArr[0] == true && vc.cellSelectArr[1] == false {
                    
                    vc.selfView.updateEView(select: false)
                    vc.selfView.updateIView(select: true)
                    vc.cellSelectArr[0] = false
                    vc.cellSelectArr[1] = true
                    
                } else if vc.cellSelectArr [0] == false && vc.cellSelectArr[1] == true {
                    
                    vc.selfView.updateIView(select: false)
                    vc.cellSelectArr[1] = false
                }
                vc.mbtiArray.accept(vc.cellSelectArr)
            }
            .disposed(by: disposeBag)
        
        output.nButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                if vc.cellSelectArr[2] == false && vc.cellSelectArr[3] == false {
                    
                    vc.selfView.updateNView(select: true)
                    vc.cellSelectArr[2] = true
                    
                } else if vc.cellSelectArr[2] == true && vc.cellSelectArr[3] == false {
                    
                    vc.selfView.updateNView(select: false)
                    vc.cellSelectArr[2] = false
                    
                } else if vc.cellSelectArr [2] == false && vc.cellSelectArr[3] == true {
                    
                    vc.selfView.updateNView(select: true)
                    vc.selfView.updateSView(select: false)
                    vc.cellSelectArr[2] = true
                    vc.cellSelectArr[3] = false
                }
                vc.mbtiArray.accept(vc.cellSelectArr)
            }
            .disposed(by: disposeBag)
        
        output.sButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                if vc.cellSelectArr[2] == false && vc.cellSelectArr[3] == false {
                    
                    vc.selfView.updateSView(select: true)
                    vc.cellSelectArr[3] = true
                    
                } else if vc.cellSelectArr[2] == true && vc.cellSelectArr[3] == false {
                    
                    vc.selfView.updateNView(select: false)
                    vc.selfView.updateSView(select: true)
                    vc.cellSelectArr[2] = false
                    vc.cellSelectArr[3] = true
                    
                } else if vc.cellSelectArr [2] == false && vc.cellSelectArr[3] == true {
                    
                    vc.selfView.updateSView(select: false)
                    vc.cellSelectArr[3] = false
                }
                vc.mbtiArray.accept(vc.cellSelectArr)
            }
            .disposed(by: disposeBag)
        
        output.tButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                if vc.cellSelectArr[4] == false && vc.cellSelectArr[5] == false {
                    
                    vc.selfView.updateTView(select: true)
                    vc.cellSelectArr[4] = true
                    
                } else if vc.cellSelectArr[4] == true && vc.cellSelectArr[5] == false {
                    
                    vc.selfView.updateTView(select: false)
                    vc.cellSelectArr[4] = false
                    
                } else if vc.cellSelectArr [4] == false && vc.cellSelectArr[5] == true {
                    
                    vc.selfView.updateTView(select: true)
                    vc.selfView.updateFView(select: false)
                    vc.cellSelectArr[4] = true
                    vc.cellSelectArr[5] = false
                }
                vc.mbtiArray.accept(vc.cellSelectArr)
            }
            .disposed(by: disposeBag)
        
        output.fButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                if vc.cellSelectArr[4] == false && vc.cellSelectArr[5] == false {
                    
                    vc.selfView.updateFView(select: true)
                    vc.cellSelectArr[5] = true
                    
                } else if vc.cellSelectArr[4] == true && vc.cellSelectArr[5] == false {
                    
                    vc.selfView.updateTView(select: false)
                    vc.selfView.updateFView(select: true)
                    vc.cellSelectArr[4] = false
                    vc.cellSelectArr[5] = true
                    
                } else if vc.cellSelectArr [4] == false && vc.cellSelectArr[5] == true {
                    
                    vc.selfView.updateFView(select: false)
                    vc.cellSelectArr[5] = false
                }
                vc.mbtiArray.accept(vc.cellSelectArr)
            }
            .disposed(by: disposeBag)
        
        output.jButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                if vc.cellSelectArr[6] == false && vc.cellSelectArr[7] == false {
                    
                    vc.selfView.updateJView(select: true)
                    vc.cellSelectArr[6] = true
                    
                } else if vc.cellSelectArr[6] == true && vc.cellSelectArr[7] == false {
                    
                    vc.selfView.updateJView(select: false)
                    vc.cellSelectArr[6] = false
                    
                } else if vc.cellSelectArr [6] == false && vc.cellSelectArr[7] == true {
                    
                    vc.selfView.updateJView(select: true)
                    vc.selfView.updatePView(select: false)
                    vc.cellSelectArr[6] = true
                    vc.cellSelectArr[7] = false
                }
                vc.mbtiArray.accept(vc.cellSelectArr)
            }
            .disposed(by: disposeBag)
        
        output.pButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                if vc.cellSelectArr[6] == false && vc.cellSelectArr[7] == false {
                    
                    vc.selfView.updatePView(select: true)
                    vc.cellSelectArr[7] = true
                    
                } else if vc.cellSelectArr[6] == true && vc.cellSelectArr[7] == false {
                    
                    vc.selfView.updateJView(select: false)
                    vc.selfView.updatePView(select: true)
                    vc.cellSelectArr[6] = false
                    vc.cellSelectArr[7] = true
                    
                } else if vc.cellSelectArr [6] == false && vc.cellSelectArr[7] == true {
                    
                    vc.selfView.updatePView(select: false)
                    vc.cellSelectArr[7] = false
                }
                vc.mbtiArray.accept(vc.cellSelectArr)
            }
            .disposed(by: disposeBag)
        
        output.mbtiValid
            .withUnretained(self)
            .bind { vc, valid in
                vc.selfView.nextButton.isEnabled = valid
                vc.selfView.nextButton.configuration?.baseBackgroundColor = valid ? .purple100 : .black80
            }
            .disposed(by: disposeBag)
    }
}
