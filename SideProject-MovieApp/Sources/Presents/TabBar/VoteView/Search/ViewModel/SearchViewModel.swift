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
        let recentCellTapped: PublishRelay<RecentSearchKeywordItem>
        let recentCharacterCancelButtonTapped: PublishRelay<RecentSearchKeywordItem>
        let recentSearchCancelButtonTapped: PublishRelay<RecentSearchKeywordItem>
        let updateSearchTextFieldTrigger: PublishRelay<String>
        let recentSearchAllDeleteButtonTapped: PublishRelay<Void>
        let recentCharacterAllDeleteButtonTapped: PublishRelay<Void>
    }
    
    struct Output{
        let animationData: PublishRelay<[AnimationData]>
        let searchText: ControlProperty<String?>
        let searchCharacterList: PublishRelay<SearchCharacterList>
        let searchWorkList: PublishRelay<SearchWorkList>
        let searchTextNil: PublishRelay<Void>
        let currentCategory: PublishRelay<SearchCategoryCase>
        let recentSearchList: PublishRelay<[RecentSearchItem?]?>
        let recentCharacterList: PublishRelay<[RecentCharacterItem?]?>
        let updateSearchTextTrigger: PublishRelay<String>
    }
    
    var animationData = PublishRelay<[AnimationData]>()
    let searchCharacterList = PublishRelay<SearchCharacterList>()
    let searchWorkList = PublishRelay<SearchWorkList>()
    let searchTextNil = PublishRelay<Void>()
    let thenCategoryChoiceForLastText = BehaviorRelay(value: "")
    let recentSearchList = PublishRelay<[RecentSearchItem?]?>()
    let recentCharacterList = PublishRelay<[RecentCharacterItem?]?>()
    let recentCharacterItemDeleteTrigger = PublishRelay<RecentCharacterItemDelete>()
    let recentSearchItemDeleteTrigger = PublishRelay<RecentSearchItemDelete>()
    let recentCharacterItemSaveTrigger = PublishRelay<RecentCharacterItemSave>()
    let recentSearchItemSaveTrigger = PublishRelay<RecentSearchItemSave>()
    let updateSearchTextTrigger = PublishRelay<String>()
    let recentSearchAllItemDeleteTrigger = PublishRelay<RecentSearchItemListDelete>()
    let recentCharacterAllItemDeleteTrigger = PublishRelay<RecentCharacterItemListDelete>()

    func transform(input: Input) -> Output {
        
        input.viewDidLoad
            .withUnretained(self)
            .bind { vm, _ in
                guard let user_id = UserDefaultManager.userId else { return }
                vm.getRecentSearchList(user_id: user_id)
                vm.getRecentCharacterList(user_id: user_id)
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
                        vm.postRecentSearchItemSave(user_id: user_id, search_content: text)
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
        
        input.recentSearchCancelButtonTapped
            .withUnretained(self)
            .bind { owner, searchItem in
                switch searchItem {
                    
                case .searchItem(let data):
                    owner.deleteRecentSearchItem(user_id: data.user_id, search_content: data.content)
                case .characterItem(_):
                    break
                }
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
                guard let user_id = UserDefaultManager.userId else { return }
                let characterInfoDTO = CharacterInfo(character_id: result.character_id, content_id: result.anime_id, anime_id: result.anime_id, character_img: result.character_img, character_name: result.character_name, character_mbti: result.character_mbti, title: result.title, is_vote: result.is_vote)
                vm.postRecentCharacterItemSave(user_id: user_id, character_id: result.character_id)
                vm.coordinator?.showVoteFlowCoordinator(characterInfo: characterInfoDTO, isVote: false)
            }
            .disposed(by: disposeBag)
        
        input.recentCharacterCancelButtonTapped
            .withUnretained(self)
            .bind { owner, recentCharacter in
                guard let user_id = UserDefaultManager.userId else { return }
                switch recentCharacter {
                case .searchItem(_):
                    return
                case .characterItem(let item):
                    guard let chrId = Int(item.character_id) else { return }
                    owner.deleteRecentCharacterItem(user_id: user_id, character_id: chrId)
                }
            }
            .disposed(by: disposeBag)
        
        recentCharacterItemDeleteTrigger
            .withUnretained(self)
            .bind { owner, item in
                owner.getRecentCharacterList(user_id: item.user_id)
            }
            .disposed(by: disposeBag)
        
        recentSearchItemDeleteTrigger
            .withUnretained(self)
            .bind { owner, item in
                owner.getRecentSearchList(user_id: item.user_id)
            }
            .disposed(by: disposeBag)
        
        recentCharacterItemSaveTrigger
            .withUnretained(self)
            .bind { owner, item in
                owner.getRecentCharacterList(user_id: item.user_id)
            }
            .disposed(by: disposeBag)
        
        recentSearchItemSaveTrigger
            .withUnretained(self)
            .bind { owner, item in
                owner.getRecentSearchList(user_id: item.user_id)
            }
            .disposed(by: disposeBag)
        
        input.recentCellTapped
            .withUnretained(self)
            .bind { owner, keyword in
                switch keyword {
                    
                case .searchItem(let searchItem):
                    owner.thenCategoryChoiceForLastText.accept(searchItem.content)
                    owner.current = .work
                    owner.currentCategory.accept(.work)
                    owner.updateSearchTextTrigger.accept(searchItem.content)

                case .characterItem(let characterItem):
                    owner.thenCategoryChoiceForLastText.accept(characterItem.character_name)
                    owner.current = .character
                    owner.currentCategory.accept(.character)
                    owner.updateSearchTextTrigger.accept(characterItem.character_name)
                }
            }
            .disposed(by: disposeBag)
        
        input.recentSearchAllDeleteButtonTapped
            .withUnretained(self)
            .bind { owner, _ in
                guard let user_id = UserDefaultManager.userId else { return }
                owner.deleteRecentSearchAllItem(user_id: user_id)
            }
            .disposed(by: disposeBag)
        
        input.recentCharacterAllDeleteButtonTapped
            .withUnretained(self)
            .bind { owner, _ in
                guard let user_id = UserDefaultManager.userId else { return }
                owner.deleteRecentCharacterAllItem(user_id: user_id)
            }
            .disposed(by: disposeBag)
        
        recentSearchAllItemDeleteTrigger
            .withUnretained(self)
            .bind { owner, data in
                owner.getRecentSearchList(user_id: data.user_id)
            }
            .disposed(by: disposeBag)
        
        recentCharacterAllItemDeleteTrigger
            .withUnretained(self)
            .bind { owner, data in
                owner.getRecentCharacterList(user_id: data.user_id)
            }
            .disposed(by: disposeBag)
        
        return Output(animationData: self.animationData,
                      searchText: input.searchText, searchCharacterList: self.searchCharacterList, searchWorkList: self.searchWorkList, searchTextNil: self.searchTextNil, currentCategory: self.currentCategory, recentSearchList: self.recentSearchList, recentCharacterList: self.recentCharacterList, updateSearchTextTrigger: self.updateSearchTextTrigger)
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

extension SearchViewModel {
    private func getRecentSearchList(user_id: String) {
        Task {
            let query = RecentSearchListQuery(user_id: user_id)
            let recentSearchList = try await voteUseCase.excuteRecentSearchList(query: query)
            print(recentSearchList, "최근 검색어 검색")
            self.recentSearchList.accept(recentSearchList.search_list)
        }
    }
}

extension SearchViewModel {
    private func getRecentCharacterList(user_id: String) {
        Task {
            let query = RecentCharacterListQuery(user_id: user_id)
            let recentCharacterList = try await voteUseCase.excuteRecentCharacterList(query: query)
            print(recentCharacterList, "최근 검색한 캐릭터 검색")
            self.recentCharacterList.accept(recentCharacterList.seen_chr_list)
        }
    }
}

extension SearchViewModel {
    private func postRecentSearchItemSave(user_id: String, search_content: String) {
        Task {
            let query = RecentSearchItemSaveQuery(user_id: user_id, search_content: search_content)
            let recentSearchItemSave = try await voteUseCase.excuteRecentSearchItemSave(query: query)
            print(recentSearchItemSave, "최근 검색어 저장 완료")
            self.recentSearchItemSaveTrigger.accept(recentSearchItemSave)
        }
    }
}

extension SearchViewModel {
    private func postRecentCharacterItemSave(user_id: String, character_id: Int) {
        Task {
            let query = RecentCharacterItemSaveQuery(user_id: user_id, character_id: character_id)
            let recentCharacterItemSave = try await voteUseCase.excuteRecentCharacterItemSave(query: query)
            print(recentCharacterItemSave, "최근 캐릭터 검색 저장 완료")
            self.recentCharacterItemSaveTrigger.accept(recentCharacterItemSave)
        }
    }
}

extension SearchViewModel {
    private func deleteRecentSearchItem(user_id: String, search_content: String) {
        Task {
            let query = RecentSearchItemDeleteQuery(user_id: user_id, search_content: search_content)
            let deleteRecentSearchItem = try await voteUseCase.excuteRecentSearchItemDelete(query: query)
            print(deleteRecentSearchItem, "검색어 삭제 완료")
            self.recentSearchItemDeleteTrigger.accept(deleteRecentSearchItem)
        }
    }
}

extension SearchViewModel {
    private func deleteRecentCharacterItem(user_id: String, character_id: Int) {
        Task {
            let query = RecentCharacterItemDeleteQuery(user_id: user_id, character_id: character_id)
            let deleteRecentCharacterItem = try await voteUseCase.excuteRecentCharacterItemDelete(query: query)
            print(deleteRecentCharacterItem, "캐릭터 삭제 완료")
            self.recentCharacterItemDeleteTrigger.accept(deleteRecentCharacterItem)
        }
    }
}

extension SearchViewModel {
    private func deleteRecentCharacterAllItem(user_id: String) {
        Task {
            let query = RecentCharacterItemListDeleteQuery(user_id: user_id)
            let deleteRecentCharacterAllItem = try await voteUseCase.excuteRecentCharacterListDelete(query: query)
            print(deleteRecentCharacterAllItem, "캐릭터 삭제 완료")
            self.recentCharacterAllItemDeleteTrigger.accept(deleteRecentCharacterAllItem)
        }
    }
}

extension SearchViewModel {
    private func deleteRecentSearchAllItem(user_id: String) {
        Task {
            let query = RecentSearchItemListDeleteQuery(user_id: user_id)
            let deleteRecentSearchAllItem = try await voteUseCase.excuteRecentSearchListDelete(query: query)
            print(deleteRecentSearchAllItem, "검색결과 전체삭제 완료")
            self.recentSearchAllItemDeleteTrigger.accept(deleteRecentSearchAllItem)
        }
    }
}
