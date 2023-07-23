//
//  ViewModelType.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import Foundation
import RxSwift

protocol ViewModelType {    
    associatedtype Input
    associatedtype Output
    var disposeBag: DisposeBag { get set }
    func transform(input: Input) -> Output
}
