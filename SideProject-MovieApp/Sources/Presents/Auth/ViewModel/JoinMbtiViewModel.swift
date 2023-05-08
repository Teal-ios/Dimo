//
//  JoinMbtiViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/06.
//

import Foundation
import RxSwift
import RxCocoa

class JoinMbtiViewModel: ViewModelType {
    
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    
    struct Input{
        let findMbtiButtonTapped: ControlEvent<Void>
        let nextButtonTapped: ControlEvent<Void>
        var sectionSelected: BehaviorSubject<[Int]>

    }
    
    struct Output{
    }
    
    init(coordinator: AuthCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.findMbtiButtonTapped.bind { [weak self] _ in
            print("Mbti 찾는 곳으로 이동")
        }.disposed(by: disposebag)
        
        input.nextButtonTapped.bind { [weak self] _ in
            print("완료")
        }.disposed(by: disposebag)
        return Output()
    }
}
