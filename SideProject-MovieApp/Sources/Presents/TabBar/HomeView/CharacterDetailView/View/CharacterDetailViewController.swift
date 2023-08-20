//
//  CharacterDetailViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import SnapKit
import Tabman
import Pageboy
import RxSwift
import RxCocoa
import Kingfisher

final class CharacterDetailViewController: TabmanViewController {
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Icon_arrow_left"), for: .normal)
        return button
    }()
    
    let customContainer : UIView = {
        let view = UIView()
        return view
    }()
    
    let detailHeaderView : DetailHeaderView = {
        let view = DetailHeaderView(title: "정대만", subTitle: "ISFJ | 더퍼스트슬램덩크")
        return view
    }()
    
    private var vc1: FeedViewController
    private var vc2: AnalyzeViewController
    private var vcs: Array<BaseViewController>
    
    private let viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterDetailUseCaseImpl = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let voteRepositoryImpl = VoteRepositoyImpl(dataTransferService: dataTransferService)
        let voteUseCaseImpl = VoteUseCaseImpl(voteRepository: voteRepositoryImpl)
        let feedViewModel = FeedViewModel(coordinator: viewModel.coordinator, characterDetailUseCase: characterDetailUseCaseImpl, character: viewModel.coordinator?.character, characterId: viewModel.coordinator?.characterId ?? PublishRelay<Int>())
        let analyeViewModel = AnalyzeViewModel(coordinator: viewModel.coordinator, voteUseCase: voteUseCaseImpl, characterId: viewModel.coordinator?.character.character_id)
        
        vc1 = .init(viewModel: feedViewModel)
        vc2 = .init(viewModel: analyeViewModel)
        
        vcs = .init([vc1, vc2])
        
        super.init(nibName: nil, bundle: nil)
    }
    
    func configureFeedViewController() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("CharacterDetailViewController: fatal error")
    }
    
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        setHierachy()
        setupLayout()
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .blur(style: .dark)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        bar.buttons.customize { button in
            button.tintColor = .black80
            button.selectedTintColor = .black5
        }
                
        bar.indicator.tintColor = .black5
        bar.indicator.weight = .light
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 35
        bar.layout.transitionStyle = .snap
        
        addBar(bar, dataSource: self, at: .custom(view: customContainer, layout: nil))
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension CharacterDetailViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "피드")
        case 1:
            return TMBarItem(title: "분석")
        default:
            let title = "Page\(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return vcs.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return vcs[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

extension CharacterDetailViewController {
    
    func setHierachy() {
        view.addSubview(detailHeaderView)
        view.addSubview(customContainer)
        view.addSubview(backButton)
    }
    func setupLayout() {
        detailHeaderView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(280)
        }
        
        customContainer.snp.makeConstraints { make in
            make.top.equalTo(detailHeaderView.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(54)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.leading.equalTo(detailHeaderView).inset(8)
            make.height.width.equalTo(24)
        }
    }
}

extension CharacterDetailViewController {
    func setupBinding() {
        let input = CharacterDetailViewModel.Input(backButtonTap: backButton.rx.tap)
        
        let output = self.viewModel.transform(input: input)
        
        output.character
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, character in
                guard let character else { return }
                self.detailHeaderView.titleLabel.text = character.character_name
                self.detailHeaderView.subTitleLabel.text = character.character_mbti ?? "미정"
                guard let image = character.character_img else { return }
                let imageURL = URL(string: image)
                self.detailHeaderView.moviePosterView.kf.setImage(with: imageURL)
                
            }
            .disposed(by: disposeBag)
        
    }
}
