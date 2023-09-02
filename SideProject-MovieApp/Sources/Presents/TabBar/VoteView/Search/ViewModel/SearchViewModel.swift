//
//  SearchViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/03.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteCoordinator?
    private var voteUseCase: VoteUseCase
    private var current: SearchCategoryCase = .work
    private var currentCategory = PublishRelay<SearchCategoryCase>()
    
    init(coordinator: VoteCoordinator?, voteUseCase: VoteUseCase) {
        self.coordinator = coordinator
        self.voteUseCase = voteUseCase
    }
    
    struct Input{
        let viewDidLoad: Observable<Void>
        let searchText: ControlProperty<String?>
        let searchTextEditFinish: PublishRelay<Void>
        let searchCategoryButtonTapped: ControlEvent<Void>
        let characterCellTapped: PublishRelay<Result>
    }
    
    struct Output{
        let animationData: PublishRelay<[AnimationData]>
        let searchText: ControlProperty<String?>
        let searchCharacterList: PublishRelay<SearchCharacterList>
        let searchWorkList: PublishRelay<SearchWorkList>
        let searchTextNil: PublishRelay<Void>
        let currentCategory: PublishRelay<SearchCategoryCase>
    }
    
    var animationData = PublishRelay<[AnimationData]>()
    let searchCharacterList = PublishRelay<SearchCharacterList>()
    let searchWorkList = PublishRelay<SearchWorkList>()
    let searchTextNil = PublishRelay<Void>()
    let thenCategoryChoiceForLastText = BehaviorRelay(value: "")
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoad
            .bind { [weak self] _ in
                print("viewDidLoad 실행")
                
            }
            .disposed(by: disposeBag)
        
        input.searchTextEditFinish
            .withLatestFrom(input.searchText)
            .withUnretained(self)
            .bind { vm, text in
                guard let user_id = UserDefaultManager.userId else { return }
                if text == "" {
                    self.searchTextNil.accept(())
                    print("이거찍혀야지")
                } else {
                    guard let text = text else { return }
                    switch self.current {
                        
                    case .character:
                        vm.getSearchCharacterList(user_id: user_id, searchText: text)
                    case .work:
                        vm.getSearchWorkList(user_id: user_id, searchText: text)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.searchCategoryButtonTapped
            .observe(on: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .withUnretained(self)
            .bind { vm, text in
                vm.coordinator?.showSearchCategoryViewController(categoryCase: self.current)
                vm.thenCategoryChoiceForLastText.accept(text ?? "")
            }
            .disposed(by: disposeBag)
        
        self.coordinator?.searchCategoryCase
            .withUnretained(self)
            .bind(onNext: { vm, searchCategoryCase in
                vm.currentCategory.accept(searchCategoryCase)
                vm.current = searchCategoryCase
            })
            .disposed(by: disposeBag)
        
        self.currentCategory
            .withUnretained(self)
            .bind { vm, categoryCase in
                guard let user_id = UserDefaultManager.userId else { return }
                let text = vm.thenCategoryChoiceForLastText.value
                switch categoryCase {
                    
                case .character:
                    if text == "" {
                        self.searchTextNil.accept(())
                        print("이거찍혀야지")
                    } else {
                        vm.getSearchCharacterList(user_id: user_id, searchText: text)
                    }
                case .work:
                    if text == "" {
                        self.searchTextNil.accept(())
                        print("이거찍혀야지")
                    } else {
                        vm.getSearchWorkList(user_id: user_id, searchText: text)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.characterCellTapped
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vm, result in
                let characterInfoDTO = CharacterInfo(character_id: result.character_id, content_id: result.anime_id, anime_id: result.anime_id, character_img: result.character_img, character_name: result.character_name, character_mbti: result.character_mbti, title: result.title, is_vote: result.is_vote)
                vm.coordinator?.showDigViewController(characterInfo: characterInfoDTO)
            }
            .disposed(by: disposeBag)
        
        return Output(animationData: self.animationData, searchText: input.searchText, searchCharacterList: self.searchCharacterList, searchWorkList: self.searchWorkList, searchTextNil: self.searchTextNil, currentCategory: self.currentCategory)
    }
}

extension SearchViewModel {
    private func getSearchCharacterList(user_id: String, searchText: String) {
        Task {
            let query = SearchCharacterListQuery(user_id: user_id, search_content: searchText)
            let searchCharacterList = try await voteUseCase.excuteSearchCharacterList(query: query)
            
            print(searchCharacterList, "서치검색완료")
            self.searchCharacterList.accept(searchCharacterList)
        }
    }
}

extension SearchViewModel {
    private func getSearchWorkList(user_id: String, searchText: String) {
        Task {
            let query = SearchWorkListQuery(user_id: user_id, search_content: searchText)
            let searchWorkList = try await voteUseCase.excuteSearchWorkList(query: query)
            
            print(searchWorkList, "서치검색완료")
            self.searchWorkList.accept(searchWorkList)
        }
    }
}
