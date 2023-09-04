//
//  AnalyzeViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import RxCocoa
import RxSwift

final class AnalyzeViewController: BaseViewController {
    
    let selfView = AnalyzeView()
    
    private var viewModel: AnalyzeViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("FeedViewController: fatal error")
    }
    
    init(viewModel: AnalyzeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    let viewDidLoadTrigger = PublishRelay<Void>()
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadTrigger.accept(())
    }
    
    override func setupBinding() {
        let input = AnalyzeViewModel.Input(viewDidLoad: self.viewDidLoadTrigger, revoteButtonTapped: self.selfView.revoteButton.rx.tap, voteButtonTapped: self.selfView.voteButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.inquireCharacterAnalyze
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, inquireCharacterAnalyze in
                vc.selfView.configureUpdateChart(with: inquireCharacterAnalyze)
                vc.selfView.configureUpdateMbtiContent(with: inquireCharacterAnalyze)
                if inquireCharacterAnalyze.my_vote_mbti == nil {
                    vc.selfView.updateUserIsVotedToCharacter(isVote: false)
                } else {
                    vc.selfView.updateUserIsVotedToCharacter(isVote: true)
                }
            }
            .disposed(by: disposeBag)
    }
}
