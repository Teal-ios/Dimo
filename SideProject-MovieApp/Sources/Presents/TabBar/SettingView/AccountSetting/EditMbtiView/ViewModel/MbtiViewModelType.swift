//
//  MbtiViewModelType.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol MbtiViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    var userMbti: BehaviorRelay<String?> { get }
    var mbtiChangedDate: BehaviorRelay<Date?> { get }
    
    func transform(input: Input) -> Output
}
