//
//  ReportViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import UIKit

final class ReportViewController: BaseViewController {

    let selfView = ReportView()

    private var viewModel: ReportViewModel

    init(viewModel: ReportViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = selfView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupBinding() {
        let input = ReportViewModel.Input(didTappedSlanUsingButton: selfView.slangUsingView.checkButton.rx.isTapped,
                                            didTappedSpoilerButton: selfView.spoilerView.checkButton.rx.isTapped,
                                            didTappedlewdnessOrViolenceButton: selfView.lewdnessOrViolenceView.checkButton.rx.isTapped,
                                            didTappedPromotionButton: selfView.promotionView.checkButton.rx.isTapped,
                                            didTappedPoliticsOrReligionButton: selfView.politicsOrReligionView.checkButton.rx.isTapped,
                                          didTappedLieInfoButton: selfView.lieInfoView.checkButton.rx.isTapped,
                                            didTappedEtcButton: selfView.etcView.checkButton.rx.isTapped,
                                            didBeginEditingTextView: selfView.reportReasonTextView.rx.didBeginEditing,
                                            textViewInput: selfView.reportReasonTextView.rx.text,
                                            didTappedReportButton: selfView.reportButton.rx.tap)

        let output = viewModel.transform(input: input)

        output.reportReason
            .withUnretained(self)
            .bind { (vc, reason) in
                switch reason {
                case .slangUsing(let isSelected):
                    vc.selfView.setupReportReasonButton(reason: .slangUsing(isSelected: isSelected))
                case .spoiler(let isSelected):
                    vc.selfView.setupReportReasonButton(reason: .spoiler(isSelected: isSelected))
                case .lewdnessOrViolence(let isSelected):
                    vc.selfView.setupReportReasonButton(reason: .lewdnessOrViolence(isSelected: isSelected))
                case .promotion(let isSelected):
                    vc.selfView.setupReportReasonButton(reason: .promotion(isSelected: isSelected))
                case .politicsOrReligion(let isSelected):
                    vc.selfView.setupReportReasonButton(reason: .politicsOrReligion(isSelected: isSelected))
                case .lieInfo(let isSelected):
                    vc.selfView.setupReportReasonButton(reason: .lieInfo(isSelected: isSelected))
                case .etc(let isSelected):
                    vc.selfView.setupReportReasonButton(reason: .etc(isSelected: isSelected))
                case .none:
                    vc.selfView.enablereportButton(false)
                }
            }
            .disposed(by: disposeBag)

        output.didBeginEditingTextView
            .withUnretained(self)
            .bind { (vc, isEditing) in
                vc.selfView.setupTextView(isEditing)
            }
            .disposed(by: disposeBag)

        output.textViewTextCountLimit
            .withUnretained(self)
            .bind { (vc, isUnderLimit) in
                if !isUnderLimit {
                    let str = String(vc.selfView.reportReasonTextView.text.prefix(100))
                    vc.selfView.reportReasonTextView.text = str
                }
            }
            .disposed(by: disposeBag)

        output.reportReasonValid
            .withUnretained(self)
            .bind { (vc, isReportValid) in
                vc.selfView.enablereportButton(isReportValid)
            }
            .disposed(by: disposeBag)
    }
}
