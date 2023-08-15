//
//  FrequentQuestionViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/15.
//

import Foundation
import RxSwift
import RxCocoa

final class FrequentQuestionViewModel: ViewModelType {
    
    var mockData: [FrequentQuestion] = [
        FrequentQuestion(title: "제목입니다",
                       answer: """
                       11111이름과, 쉬이 별에도 어머님, 노새, 이름과 봅니다. 가슴속에 무덤 어머니 그러나 잔디가 별 거외다. 이름과, 둘 위에도 아침이 어머님, 별 지나고 언덕 까닭입니다.

                       이름자를 어머님, 하나의 않은 청춘이 버리었습니다. 불러 계절이 하나에 하나에 까닭입니다. 멀리 시인의 이름자를 소학교 마리아 추억과 슬퍼하는 하늘에는 버리었습니다.  DIMO 드림
                       """
                      ),
        FrequentQuestion(title: "제목입니다",
                       answer: """
                       22222이름과, 쉬이 별에도 어머님, 노새, 이름과 봅니다. 가슴속에 무덤 어머니 그러나 잔디가 별 거외다. 이름과, 둘 위에도 아침이 어머님, 별 지나고 언덕 까닭입니다.

                       이름자를 어머님, 하나의 않은 청춘이 버리었습니다. 불러 계절이 하나에 하나에 까닭입니다. 멀리 시인의 이름자를 소학교 마리아 추억과 슬퍼하는 하늘에는 버리었습니다.  DIMO 드림
                       """
                      ),
        FrequentQuestion(title: "제목입니다",
                       answer: """
                       33333 이름과, 쉬이 별에도 어머님, 노새, 이름과 봅니다. 가슴속에 무덤 어머니 그러나 잔디가 별 거외다. 이름과, 둘 위에도 아침이 어머님, 별 지나고 언덕 까닭입니다.

                       이름자를 어머님, 하나의 않은 청춘이 버리었습니다. 불러 계절이 하나에 하나에 까닭입니다. 멀리 시인의 이름자를 소학교 마리아 추억과 슬퍼하는 하늘에는 버리었습니다.  DIMO 드림
                       """
                      ),
        FrequentQuestion(title: "제목입니다",
                       answer: """
                       44444이름과, 쉬이 별에도 어머님, 노새, 이름과 봅니다. 가슴속에 무덤 어머니 그러나 잔디가 별 거외다. 이름과, 둘 위에도 아침이 어머님, 별 지나고 언덕 까닭입니다.

                       이름자를 어머님, 하나의 않은 청춘이 버리었습니다. 불러 계절이 하나에 하나에 까닭입니다. 멀리 시인의 이름자를 소학교 마리아 추억과 슬퍼하는 하늘에는 버리었습니다.  DIMO 드림
                       """
                      ),
    ]
    
    let coordinator: SettingCoordinator?
    let settingUseCase: SettingUseCase
    
    var disposeBag = DisposeBag()
    
    init(coordinator: SettingCoordinator? = nil, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    struct Input {
        let noticeCellSelected: PublishRelay<NoticeContents>
    }

    private var isHiddenContents = BehaviorRelay<Bool>(value: false)

    struct Output {
        let isHiddenContents: BehaviorRelay<Bool>
    }

    func transform(input: Input) -> Output {

        input.noticeCellSelected
            .withUnretained(self)
            .bind(onNext: { (vm, _) in
                vm.isHiddenContents.accept(false)
            })
            .disposed(by: disposeBag)

        return Output(isHiddenContents: self.isHiddenContents)
    }
}
