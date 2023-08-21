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
        FrequentQuestion(title: "DIMO는 어떤 서비스인가요?",
                       answer: """
                       당신의 과몰입이 완성되는 곳, DIMO는 콘텐츠를 향한 과몰입으로 나를 찾고, 발견하고, 표현할 수 있는 커뮤니티 어플입니다. 나의 MBTI를 입력한 뒤, 나와 같은 MBTI를 가지고 있는 캐릭터들을 만나보세요. 또한 DIMO에서는 나와 같은 MBTI를 가진 사람들이 좋아한 콘텐츠도 함께 추천받아 볼 수 있답니다.
                       """
                      ),
        FrequentQuestion(title: "MBTI 투표는 어떤 기능인가요?",
                       answer: """
                       내가 재미있게 본 작품 속 캐릭터들은 어떤 MBTI를 가지고 있을까요? MBTI 투표 기능을 통해 캐릭터의 MBTI를 추측해보고, 다른 사용자들과 의견을 나누어 보세요. 캐릭터의 MBTI 투표를 완료하면 다른 사용자들이 응답한 결과도 함께 확인해볼 수 있어요.
                       """
                      ),
        FrequentQuestion(title: "내가 찾는 캐릭터가 없어요.",
                       answer: """
                       내가 찾고 있는 캐릭터가 DIMO에 없을 경우, 설정 > 캐릭터 요청하기를 통해 새로운 캐릭터를 요청할 수 있어요. 요청하신 캐릭터는 빠른 시일 내에 TEAM DIMO에서 검토한 뒤 반영해드릴 예정이에요.
                       """
                      ),
        FrequentQuestion(title: "내 MBTI를 모르겠어요.",
                       answer: """
                       설정 > MBTI 변경에서 ‘나의 MBTI를 잘 모르겠어요’를 클릭하면 MBTI 검사 페이지(https://www.16personalities.com/ko)로 연결됩니다. 검사를 마치신 후 DIMO 어플 내에서 MBTI를 입력해주세요.
                       """
                      ),
        FrequentQuestion(title: "내 MBTI를 바꾸고 싶어요.",
                       answer: """
                       내 MBTI는 설정 > MBTI 변경에서 변경할 수 있어요. 단, MBTI는 한 달에 한 번만 변경할 수 있으니 신중하게
                       결정해주세요.
                       """
                      ),
        FrequentQuestion(title: "캐릭터의 MBTI는 어떻게 정해진 건가요?",
                       answer: """
                       캐릭터의 MBTI는 다른 사용자들의 응답이 모두 반영되어 결정됩니다. 캐릭터 상세페이지에 들어가면 DIMO 사용자들에게서 가장 많은 표를 받은 MBTI의 순위와 비율을 확인해볼 수 있어요.
                       """
                      ),
        FrequentQuestion(title: "스포일러를 당했어요.",
                       answer: """
                       리뷰 또는 댓글을 통해 스포일러를 하는 행위는 DIMO의 이용방침을 위배하는 행위에 해당해요. 스포일러 표시 없이 콘텐츠 또는 캐릭터와 관련된 스포일러를 무분별하게 퍼뜨리는 사용자를 발견했을 시에는, 게시글 상단의 […] 버튼을 클릭하여 신고해주세요.다. 검사를 마치신 후 DIMO 어플 내에서 MBTI를 입력해주세요.
                       """
                      ),
        FrequentQuestion(title: "보고 싶지 않은 리뷰가 있어요.",
                       answer: """
                       게시글 상단의 […] 버튼을 클릭하여 해당 리뷰를 가리거나, 리뷰 작성자의 모든 리뷰를 가릴 수 있어요. 해당 게시글이 DIMO 이용방침을 위배하는 내용을 담고 있을 경우에는 [작성자 신고하기] 버튼을 클릭하여 신고해주세요.
                       """
                      ),
        FrequentQuestion(title: "DIMO에서 탈퇴하고 싶어요.",
                       answer: """
                       DIMO를 떠나고 싶다면, 설정 > 내 정보 변경 > 회원 탈퇴를 이용해주세요. 탈퇴 시 사유를 함께 응답해주시면 DIMO의 서비스 개선에 많은 도움이 됩니다. 아쉽지만 더 좋은 기회로 다시 만날 수 있기를 바라요!
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
