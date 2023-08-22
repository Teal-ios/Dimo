//
//  CharacterAskViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/21.
//

import Foundation
import RxSwift
import RxCocoa

final class CharacterAskViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    private weak var coordinator: SettingCoordinator?
    private var settingUseCase: SettingUseCase
    
    struct Input {
        let isTappedMovieButton: ControlProperty<Bool>
        let isTappedAnimationButton: ControlProperty<Bool>
        let productTitleTextFieldText: ControlProperty<String?>
        let chracterNameTextFieldText:ControlProperty<String?>
        let didTappedAskButton: ControlEvent<Void>
    }
    
    private var productTitle: String?
    private var characterName: String?
    private var isTappedMovieButton = BehaviorRelay<Bool>(value: false)
    private var isTappedAnimationButton = BehaviorRelay<Bool>(value: false)
    private var didAskedCharacter = BehaviorRelay<Bool>(value: false)

    struct Output {
        let isRequestable: Observable<(Bool, Bool, Bool, Bool)>
        let isTappedMovieButton: BehaviorRelay<Bool>
        let isTappedAnimationButton: BehaviorRelay<Bool>
        let didAskedCharacter: BehaviorRelay<Bool>
    }
    
    init(coordinator: SettingCoordinator?, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(input: Input) -> Output {
        
        let isValidProductTitle = input.productTitleTextFieldText
            .orEmpty
            .map { $0.count > 0 }
        
        let isValidCharacterName = input.chracterNameTextFieldText
            .orEmpty
            .map { $0.count > 0 }
        
        let isRequestable = Observable.combineLatest(isTappedMovieButton,
                                                     isTappedAnimationButton,
                                                     isValidProductTitle,
                                                     isValidCharacterName)
        
        input.productTitleTextFieldText
            .withUnretained(self)
            .bind { (vm, productTitle) in
                vm.productTitle = productTitle
            }
            .disposed(by: disposeBag)
        
        input.chracterNameTextFieldText
            .withUnretained(self)
            .bind { (vm, characterName) in
                vm.characterName = characterName
            }
            .disposed(by: disposeBag)
        
        input.isTappedMovieButton
            .withUnretained(self)
            .bind { (vm, isTapped) in
                vm.isTappedMovieButton.accept(isTapped)
                vm.isTappedAnimationButton.accept(false)
            }
            .disposed(by: disposeBag)
        
        input.isTappedAnimationButton
            .withUnretained(self)
            .bind { (vm, isTapped) in
                vm.isTappedMovieButton.accept(false)
                vm.isTappedAnimationButton.accept(isTapped)
            }
            .disposed(by: disposeBag)
        
        input.didTappedAskButton
            .withUnretained(self)
            .bind { (vm, _) in
                let category = vm.isTappedMovieButton.value == true ? "영화" : "애니"
                guard let title = vm.productTitle,
                      let characterName = vm.characterName else { return }
                vm.loadAskCharacter(category, title, characterName)
            }
            .disposed(by: disposeBag)
        
        return Output(isRequestable: isRequestable,
                      isTappedMovieButton: self.isTappedMovieButton,
                      isTappedAnimationButton: self.isTappedAnimationButton,
                      didAskedCharacter: self.didAskedCharacter)
    }
}

extension CharacterAskViewModel {
    
    private func loadAskCharacter(_ category: String, _ title: String, _ characterName: String) {
        guard let userId = UserDefaultManager.userId else { return }
        
        let query = CharacterAskQuery(user_id: userId, category: category, title: title, character_name: characterName)
        
        Task {
            let characterAsk = try await settingUseCase.executeCharacterAsk(query: query)
            
            print("🔥", characterAsk)
            if characterAsk.code == 200 {
                didAskedCharacter.accept(true)
            }
        }
    }
}
