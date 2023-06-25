//
//  BaseViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    // MARK: Properties
    
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    
    var disposeBag = DisposeBag()
    
    
    // MARK: Layout Constraints
    
    private(set) var didSetupConstraints = false
    
    
    // MARK: Initializing
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupLifeCycleBinding()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupLifeCycleBinding()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLifeCycleBinding()
    }
    
    
    // MARK: Life Cycle Views
    
    override func viewDidLoad() {
        setupAttributes()
        setupLayout()
        setupLocalization()
        setupBinding()
        setData()
        navigation()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    
    // MARK: Setup
    
    func setupLayout() {
        // Override Layout
    }
    
    func setupConstraints() {
        // Override Constraints
    }
    
    func setupAttributes() {
        // Override Attributes
//        view.backgroundColor = Color.white
//        navigation()
//        view.backgroundColor = Color.mainContainerBackgroundColor
    }
    
    func setupLocalization() {
        // Override Localization
    }
    
    func setupLifeCycleBinding() {
        // Override Binding for Lify Cycle Views
    }
    
    func setupBinding() {
        // Override Binding
    }
    
    func setData() {
        // Override Set Data
    }
    
    
    // MARK: Custom Func
    
    func navigation() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .black
        
        let backImage = UIImage(named: "arrow")?.withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -100.0, bottom: 0.0, right: 0.0))
        

        navigationBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black60
        navigationController?.view.backgroundColor = .black              /// Navagation 배경 색상을 지정
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func configureNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil   /// navigation bar를 hidden 처리 하더라도 swipe Gesture는 작동하도록!!
    }
}



extension BaseViewController {
    
    func showAlertMessage(title: String, button: String = "확인") {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func showSelectAlertMessage(title: String, button: String = "확인", handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let canel = UIAlertAction(title: "아니요", style: .cancel)
        let ok = UIAlertAction(title: button, style: .default) { _ in
            handler?()
        }
        alert.addAction(ok)
        alert.addAction(canel)
        present(alert, animated: true)
    }
    
    
    
    
    /// scroll in textfield
    func keyBoardHiddenGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
//      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//      view.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
      view.endEditing(true)
    }
}

