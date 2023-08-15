//
//  ExpandableListCell.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/13.
//

import UIKit
import SnapKit

final class ExpandableListCell: BaseCollectionViewCell {
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4.0
        return stackView
    }()
        
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목입니다"
        label.textColor = .black5
        label.font = .suitFont(ofSize: 16, weight: .Medium)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2020.10.10"
        label.textColor = .black60
        label.font = .suitFont(ofSize: 12, weight: .Medium)
        return label
    }()
    
    let expansionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Icon_arrow_bottom"), for: .normal)
        return button
    }()
    
    let noticeMessageLabel: BasePaddingLabel = {
        let label = BasePaddingLabel()
        label.font = .suitFont(ofSize: 14, weight: .Medium)
        label.textColor = .black5
        label.numberOfLines = 0
        label.backgroundColor = .black90
        label.layer.cornerRadius = 8.0
        label.clipsToBounds = true
        return label
    }()
    
    var expandedConstraint: Constraint?
    
    var foldedConstraint: Constraint?
    
    override var isSelected: Bool {
        didSet {
            changeConstraint()
        }
    }
    
    convenience init(isHiddenSubTitleLabel: Bool) {
        self.init()
        subTitleLabel.isHidden = isHiddenSubTitleLabel
    }
    
    func configure(_ viewModel: ExpandableListCellViewModel) {
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        noticeMessageLabel.text = viewModel.message
    }
        
    override func setHierarchy() {
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subTitleLabel)
        
        containerStackView.addArrangedSubview(titleStackView)
        containerStackView.addArrangedSubview(noticeMessageLabel)
        
        contentView.addSubview(containerStackView)
        contentView.addSubview(expansionButton)
    }
    
    override func setConstraints() {
        
        containerStackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16)
        }
        
        titleStackView.snp.makeConstraints { make in
            foldedConstraint = make.bottom.equalTo(contentView.snp.bottom).offset(-16).priority(250).constraint
            make.height.equalTo(44)
        }
        
        expansionButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide)
            make.centerY.equalTo(titleStackView.snp.centerY)
            make.width.height.equalTo(40)
        }
        
        noticeMessageLabel.snp.makeConstraints { make in
            expandedConstraint = make.bottom.equalTo(contentView.snp.bottom).offset(-16).priority(250).constraint
        }
        
        foldedConstraint?.activate()
        expandedConstraint?.deactivate()
    }
}

extension ExpandableListCell {
    
    func changeConstraint() {
        if isSelected {
            foldedConstraint?.deactivate()
            expandedConstraint?.activate()
        } else {
            foldedConstraint?.activate()
            expandedConstraint?.deactivate()
        }
        
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * 0.999)
            self.expansionButton.transform = self.isSelected ? upsideDown : .identity
        }
    }
}

struct ExpandableListCellViewModel {
    let title: String
    let subTitle: String?
    let message: String
    var isExpanded: Bool = false
}
