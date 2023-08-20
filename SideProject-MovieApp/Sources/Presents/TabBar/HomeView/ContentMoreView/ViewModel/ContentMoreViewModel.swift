//
//  ContentMoreViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import Foundation
import RxSwift
import RxCocoa

final class ContentMoreViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    
    init(coordinator: HomeCoordinator? = nil, content: [Hit]) {
        self.coordinator = coordinator
        self.contentData = BehaviorRelay(value: content)
    }
    
    struct Input{
        let viewDidLoad: PublishRelay<Void>

    }
    
    struct Output{
        let contentData: BehaviorRelay<[Hit]>
    }
    
    var contentData = BehaviorRelay<[Hit]>(value: [])
    
    func transform(input: Input) -> Output {

        return Output(contentData: self.contentData)
    }
}
