//
//  IamTheMainCharacterHeader.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/21.
//

import UIKit
import SnapKit

class IamTheMainCharacterHeader: UICollectionReusableView {
    static let identifier = String(describing: IamTheMainCharacterHeader.self)
    
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let leading = 16.0
        let safeArea = self.safeAreaLayoutGuide
        label.snp.makeConstraints { make in
            make.leading.equalTo(leading)
            make.centerY.equalTo(safeArea)
        }
    }
}
