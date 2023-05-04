//
//  CategoryView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import SnapKit

class CategoryView: BaseView {
        
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black100
        view.alpha = 0.35
        return view
    }()
    
    let baseCategoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .black80
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white100
        label.font = Font.title3
        label.text = "존재하지 않는 회원정보"
        label.textAlignment = .center
        return label
    }()
    
    
    let movieButton: UIButton = {
        let button = UIButton()
        button.setTitle("영화", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let dramaButton: UIButton = {
        let button = UIButton()
        button.setTitle("드라마", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseCategoryView.layer.cornerRadius = 8
    }
    
    override func setupLayout() {
        [bgView, baseCategoryView, titleLabel, movieButton, dramaButton].forEach { self.addSubview($0) }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        baseCategoryView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(168)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(baseCategoryView.snp.top)
            make.height.equalTo(64)
        }
        
        movieButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(52)
        }
        
        dramaButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(movieButton.snp.bottom)
            make.height.equalTo(52)
        }
    }
}
