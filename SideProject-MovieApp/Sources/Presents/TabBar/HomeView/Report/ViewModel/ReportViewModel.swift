//
//  ReportViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import Foundation
import RxCocoa
import RxSwift

class ReportViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private var characterDetailUseCase: CharacterDetailUseCase
    
    enum ReportReason: Equatable {
        case slangUsing(isSelected: Bool)
        case spoiler(isSelected: Bool)
        case lewdnessOrViolence(isSelected: Bool)
        case promotion(isSelected: Bool)
        case politicsOrReligion(isSelected: Bool)
        case lieInfo(isSelected: Bool)
        case etc(isSelected: Bool)
        
        var withdrawReason: String {
            switch self {
            case .slangUsing: return "비속어 사용"
            case .spoiler: return "스포일러"
            case .lewdnessOrViolence: return "음란 폭력"
            case .promotion: return "홍보"
            case .politicsOrReligion: return "정치·종교적 발언"
            case .lieInfo: return "거짓 정보"
            case .etc: return "기타"
            }
        }
    }
    
    struct Input {
        let didTappedSlanUsingButton: ControlProperty<Bool>
        let didTappedSpoilerButton: ControlProperty<Bool>
        let didTappedlewdnessOrViolenceButton: ControlProperty<Bool>
        let didTappedPromotionButton: ControlProperty<Bool>
        let didTappedPoliticsOrReligionButton: ControlProperty<Bool>
        let didTappedLieInfoButton: ControlProperty<Bool>
        let didTappedEtcButton: ControlProperty<Bool>
        let didBeginEditingTextView: ControlEvent<Void>
        let textViewInput: ControlProperty<String?>
        let didTappedReportButton: ControlEvent<Void>
    }
    
    private var reportReason = BehaviorRelay<ReportReason?>(value: nil)
    private var reportReasonTextView = BehaviorRelay<String?>(value: nil)
    private var didBeginEditingTextView = BehaviorRelay(value: false)
    
    struct Output {
        let reportReason: BehaviorRelay<ReportReason?>
        let didBeginEditingTextView: BehaviorRelay<Bool>
        let textViewTextCountLimit: Observable<Bool>
        let reportReasonValid: Observable<Bool>
    }
    
    init(coordinator: TabmanCoordinator?, characterDetailUseCase: CharacterDetailUseCase) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
    }
    
    func transform(input: Input) -> Output {
        
        input.didTappedSlanUsingButton
            .withUnretained(self)
            .bind { (vm, isTapped) in
                vm.reportReason.accept(.slangUsing(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedSpoilerButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.reportReason.accept(.spoiler(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedlewdnessOrViolenceButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.reportReason.accept(.lewdnessOrViolence(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedPromotionButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.reportReason.accept(.promotion(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedPoliticsOrReligionButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.reportReason.accept(.politicsOrReligion(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedLieInfoButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.reportReason.accept(.lieInfo(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didTappedEtcButton
            .withUnretained(self)
            .bind { vm, isTapped in
                vm.reportReason.accept(.etc(isSelected: isTapped))
            }
            .disposed(by: disposeBag)
        
        input.didBeginEditingTextView
            .withUnretained(self)
            .bind { (vc, _) in
                self.didBeginEditingTextView.accept(true)
            }
            .disposed(by: disposeBag)
                      
        
        let textViewTextCountLimit =  input.textViewInput.orEmpty
            .map { $0.count <= 100 }
            .share()
                      
        input.textViewInput
            .withUnretained(self)
            .bind { (vc, text) in
                self.reportReasonTextView.accept(text)
            }
            .disposed(by: disposeBag)
        
        let reportReason = self.reportReason
            .map { $0 == ReportReason.slangUsing(isSelected: true) ||
                    $0 == ReportReason.spoiler(isSelected: true) ||
                    $0 == ReportReason.lewdnessOrViolence(isSelected: true) ||
                    $0 == ReportReason.promotion(isSelected: true) ||
                    $0 == ReportReason.politicsOrReligion(isSelected: true) ||
                $0 == ReportReason.lieInfo(isSelected: true) ||
                    $0 == ReportReason.etc(isSelected: true) }
            .share()
        
        input.didTappedReportButton
            .withUnretained(self)
            .bind { (vm, _) in

            }
            .disposed(by: disposeBag)
                    
        return Output(reportReason: self.reportReason,
                      didBeginEditingTextView: self.didBeginEditingTextView,
                      textViewTextCountLimit: textViewTextCountLimit,
                      reportReasonValid: reportReason)
    }
}

extension ReportViewModel {
    private func postReport(user_id: String, review_id: Int, report_reason: String) {
        Task {
            
        }
    }
}
