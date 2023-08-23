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
    private var current: SearchCategoryCase = .character

    init(coordinator: VoteCoordinator?, voteUseCase: VoteUseCase) {
        self.coordinator = coordinator
        self.voteUseCase = voteUseCase
    }
    
    struct Input{
        let viewDidLoad: Observable<Void>
        let searchText: ControlProperty<String?>
        let searchTextEditFinish: PublishRelay<Void>
    }
    
    struct Output{
        let animationData: PublishRelay<[AnimationData]>
        let searchText: ControlProperty<String?>
        let searchCharacterList: PublishRelay<SearchCharacterList>
        let searchTextNil: PublishRelay<Void>
    }
    
    var animationData = PublishRelay<[AnimationData]>()
    let searchCharacterList = PublishRelay<SearchCharacterList>()
    let searchTextNil = PublishRelay<Void>()

    
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
                        print("미구현")
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(animationData: self.animationData, searchText: input.searchText, searchCharacterList: self.searchCharacterList, searchTextNil: self.searchTextNil)
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
