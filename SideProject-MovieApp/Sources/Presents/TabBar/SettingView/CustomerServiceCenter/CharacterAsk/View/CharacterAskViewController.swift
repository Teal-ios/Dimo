//
//  CharacterAskViewController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class CharacterAskViewController: BaseViewController {
    
    private let characterAskView = CharacterAskView()
    private var viewModel: CharacterAskViewModel
    
    private lazy var input = CharacterAskViewModel.Input(isTappedMovieButton:  characterAskView.movieView.checkButton.rx.isTapped,
                                                         isTappedAnimationButton: characterAskView.animationView.checkButton.rx.isTapped,
                                                         productTitleTextFieldText: characterAskView.productTitleView.tf.rx.text,
                                                         chracterNameTextFieldText: characterAskView.characterNameView.tf.rx.text,
                                                         didTappedAskButton: characterAskView.askButton.rx.tap)
    
    init(viewModel: CharacterAskViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        self.view = characterAskView
    }
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
        output.isTappedMovieButton
            .withUnretained(self)
            .bind { (vc, isTapped) in
                vc.characterAskView.updateMovieViewButtonState(isTapped)
            }
            .disposed(by: disposeBag)
        
        output.isTappedAnimationButton
            .withUnretained(self)
            .bind { (vc, isTapped) in
                vc.characterAskView.updateAnimationViewButtonState(isTapped)
            }
            .disposed(by: disposeBag)
        
        output.isRequestable
            .bind { [weak self] (isTappedMovieButton, isTappedAnimationButton, isValidProductTitle, isValidCharacterName) in
                let isRequestable = (isTappedMovieButton || isTappedAnimationButton) && isValidProductTitle && isValidCharacterName
                self?.characterAskView.updateAskButtonState(isRequestable)
            }
            .disposed(by: disposeBag)
        
        output.didAskedCharacter
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { (vc, isAsked) in
                if isAsked {
                    self.characterAskView.makeToast("요청을 완료했어요", style: ToastStyle.dimo)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
