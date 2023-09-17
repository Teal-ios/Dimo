//
//  CategoryActionSheetController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/16.
//

import UIKit
import RxSwift
import RxCocoa

final class SortActionSheetViewController: BaseViewController {
    
    let sortActionSheetView = SortActionSheetView()
    var characterNameSortAction: UIAction?
    var productionTitleSortAction: UIAction?
    
    init(_ characterNameSortAction: UIAction?, _ productionTitleSortAction: UIAction?) {
        self.characterNameSortAction = characterNameSortAction
        self.productionTitleSortAction = productionTitleSortAction
        super.init()
    }
    
    override func loadView() {
        self.view = sortActionSheetView
    }
    
    override func viewDidLoad() {
        self.addBackgroundViewGesture() 
        self.addCharacterNameSortButtonAction(action: characterNameSortAction)
        self.addProductionTitleSortButtonAction(action: productionTitleSortAction)
    }
    
    func addBackgroundViewGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedBackgroundView))
        sortActionSheetView.addBackgroundViewGesture(tapGesture)
    }
    
    @objc func didTappedBackgroundView() {
        self.dismiss(animated: true)
    }
}

extension SortActionSheetViewController {
    
    private func addCharacterNameSortButtonAction(action: UIAction?) {
        guard let action = action else { return }
        sortActionSheetView.addCharacterNameButtonAction(action: action, event: .touchUpInside)
    }
    
    private func addProductionTitleSortButtonAction(action: UIAction?) {
        guard let action = action else { return }
        sortActionSheetView.addPproductionTitleButtonAction(action: action, event: .touchUpInside)
    }
}
