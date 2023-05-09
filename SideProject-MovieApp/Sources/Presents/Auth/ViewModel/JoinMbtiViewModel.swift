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

    }
    
    struct Output{
    }
    var indexPathCell: PublishSubject<Int> = PublishSubject()
    var sectionSelected: BehaviorRelay<[Bool]> = BehaviorRelay(value: [false, false, false, false, false, false, false, false])
    
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
        
        self.indexPathCell.bind { [weak self] index in
            var indexArr = self?.sectionSelected.value ?? []
            if index == 0 {
                if indexArr[0] == false {
                    if indexArr[1] == false {
                        indexArr[0] = true
                    } else {
                        indexArr[0] = true
                        indexArr[1] = false
                    }
                } else { // indexArr[0] 이 true일 때
                    if indexArr[1] == false {
                        indexArr[0] = false
                    } else {
                        indexArr[1] = false
                        indexArr[0] = true
                    }
                }
            } else if index == 1 {
                if indexArr[1] == false {
                    if indexArr[0] == false {
                        indexArr[1] = true
                    } else {
                        indexArr[1] = true
                        indexArr[0] = false
                    }
                } else { // indexArr[0] 이 true일 때
                    if indexArr[0] == false {
                        indexArr[1] = false
                    } else {
                        indexArr[0] = false
                        indexArr[1] = true
                    }
                }
            }
            print(indexArr)
        }.disposed(by: disposebag)

        return Output()
    }
}
