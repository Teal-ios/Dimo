//
//  CurrentMbtiViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/20.
//

import Foundation
import RxSwift
import RxCocoa

final class UserMbtiViewModel: ViewModelType, MbtiViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    var userMbti = BehaviorRelay<String?>(value: nil)
    var mbtiChangedDate = BehaviorRelay<Date?>(value: nil)
    
    struct Input {
        
    }
    
    struct Output {
        let mbtiChangeDate: BehaviorRelay<Date?>
    }
    
    init(mbti: String?, mbtiChangeDate: Date?) {
        self.userMbti.accept(mbti)
        self.mbtiChangedDate.accept(mbtiChangeDate)
    }
    
    func transform(input: Input) -> Output {
        return Output(mbtiChangeDate: self.mbtiChangedDate)
    }
}
