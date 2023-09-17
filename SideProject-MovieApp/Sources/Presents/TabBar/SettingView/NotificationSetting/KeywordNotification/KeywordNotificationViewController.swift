//
//  TabmanController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Tabman
import Pageboy

final class KeywordNotificationViewController: TabmanViewController {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white100
        label.font = Font.title1
        label.text = "키워드 알림"
        return label
    }()
    
    let tabBarButtonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let viewModel: KeywordNotificationViewModel
//    private var productNotificationViewController: ProductNotificationViewController
//    private var mbtiNotificationViewController: MBTINotificationViewController
    private var viewControllers: [BaseViewController]
    
    init(with viewModel: KeywordNotificationViewModel, _ viewControllers: [BaseViewController]) {
        self.viewModel = viewModel
//        let dataTransferService = DataTransferService(networkService: NetworkService())
//        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
//        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
//
//        let productNotificationViewModel = ProductNotificationViewModel(coordinator: viewModel.coordinator, networkUsecase: settingUseCaseImpl)
//        let mbtiNotificationViewModel = MBTINotificationViewModel(coordinator: viewModel.coordinator, networkUsecase: settingUseCaseImpl)
//
//        self.productNotificationViewController = ProductNotificationViewController(viewModel: productNotificationViewModel)
//        self.mbtiNotificationViewController = MBTINotificationViewController(viewModel: mbtiNotificationViewModel)
//
//        self.viewControllers = .init([productNotificationViewController, mbtiNotificationViewController])
        self.viewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.setHierarchy()
        self.setupLayout()
        self.addTabButtonBar()
    }
    
    func addTabButtonBar() {
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .clear
        bar.backgroundColor = .clear
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
        addBar(bar, dataSource: self, at: .custom(view: tabBarButtonContainerView, layout: nil))
    }

    func setupTabBar() {
        
    }
    
}

extension KeywordNotificationViewController: TMBarDataSource {
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "작품・캐릭터")
        case 1:
            return TMBarItem(title: "MBTI")
        default:
            return TMBarItem(title: "")
        }
    }
}

extension KeywordNotificationViewController: PageboyViewControllerDataSource {
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
}

extension KeywordNotificationViewController {
    func setHierarchy() {
        view.addSubview(headerLabel)
        view.addSubview(tabBarButtonContainerView)
    }
    
    func setupLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(16)
            make.height.equalTo(44)
        }
        
        tabBarButtonContainerView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(54)
        }
    }
}
