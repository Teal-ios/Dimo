//
//  MovieDetailView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import SnapKit

final class MovieDetailView: BaseView {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(characterCollectionView)
        view.addSubview(gradeTitleLabel)
        view.addSubview(gradeContainView)
        view.addSubview(mbtiPreferContainView)
        view.addSubview(detailLabel)
        view.addSubview(unfoldButton)
        view.addSubview(arrowBottomLabel)
        view.addSubview(unfoldStackView)
        view.addSubview(unfoldExplainStackView)
        return view
    }()
    
    let gradeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.text = "평점 TOP3"
        return label
    }()
    
    let gradeContainView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .black90
        return view
    }()
    
    let mbtiPreferContainView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .black90
        return view
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.text = "상세정보"
        return label
    }()
    
    let unfoldButton: WordLabelButton = {
        let button = WordLabelButton(text: "펼치기")
        return button
    }()
    
    let arrowBottomLabel: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow_bottom")
        return view
    }()
    
    lazy var unfoldStackView: UIStackView = {
        let view = UIStackView()
        view.isHidden = true
        view.distribution = .fillEqually
        view.spacing = 0
        view.axis = .vertical
        view.addArrangedSubview(categoryLabel)
        view.addArrangedSubview(genreLabel)
        view.addArrangedSubview(releaseLabel)
        view.addArrangedSubview(runningTimeLabel)
        view.addArrangedSubview(creatorLabel)
        view.addArrangedSubview(audienceLabel)
        return view
    }()
    
    lazy var unfoldExplainStackView: UIStackView = {
        let view = UIStackView()
        view.isHidden = true
        view.distribution = .fillEqually
        view.spacing = 0
        view.axis = .vertical
        view.addArrangedSubview(categoryExplainLabel)
        view.addArrangedSubview(genreExplainLabel)
        view.addArrangedSubview(releaseExplainLabel)
        view.addArrangedSubview(runningTimeExplainLabel)
        view.addArrangedSubview(creatorExplainLabel)
        view.addArrangedSubview(audienceExplainLabel)
        return view
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.subtitle3
        label.text = "카테고리"
        return label
    }()
    
    let categoryExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "영화"
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.subtitle3
        label.text = "장르"
        return label
    }()
    
    let genreExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "애니메이션"
        return label
    }()
    
    let releaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.subtitle3
        label.text = "공개"
        return label
    }()
    
    let releaseExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "2023"
        return label
    }()
    
    let runningTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.subtitle3
        label.text = "러닝타임"
        return label
    }()
    
    let runningTimeExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "124분"
        return label
    }()
    
    let creatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.subtitle3
        label.text = "크리에이터"
        return label
    }()
    
    let creatorExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "이노우에 다케히코"
        return label
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.subtitle3
        label.text = "관람가"
        return label
    }()
    
    let audienceExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.text = "15세 이상 관람가"
        return label
    }()
    
    lazy var characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private let itemRatio = 1.0
    private let groupRatio = 0.92
    private let headerRatio = 1.0
    private let headerAbsolute = 520.0
    
    override func setHierarchy() {
        self.addSubview(scrollView)
    }
    
    override func setupLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        characterCollectionView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.top)
            make.height.equalTo(700)
        }
        
        gradeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(scrollView.safeAreaInsets).inset(16)
            make.height.equalTo(20)
        }
        
        gradeContainView.snp.makeConstraints { make in
            make.top.equalTo(gradeTitleLabel.snp.bottom).offset(16)
            make.height.equalTo(176)
            make.horizontalEdges.equalTo(scrollView.safeAreaLayoutGuide).inset(16)
        }
        
        mbtiPreferContainView.snp.makeConstraints { make in
            make.top.equalTo(gradeContainView.snp.bottom).offset(16)
            make.height.equalTo(56)
            make.horizontalEdges.equalTo(scrollView.safeAreaLayoutGuide).inset(16)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(mbtiPreferContainView.snp.bottom).offset(36)
            make.height.equalTo(20)
            make.leading.equalTo(scrollView.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(60)
        }
        
        unfoldButton.snp.makeConstraints { make in
            make.top.equalTo(mbtiPreferContainView.snp.bottom).offset(36)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.trailing.equalTo(scrollView.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(60)
        }
        
        arrowBottomLabel.snp.makeConstraints { make in
            make.centerY.equalTo(unfoldButton)
            make.height.equalTo(19)
            make.trailing.equalTo(scrollView.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(arrowBottomLabel.snp.height)
        }
        
        //        unfoldStackView.snp.makeConstraints { make in
        //            make.height.equalTo(222)
        //            make.leading.equalTo(16)
        //            make.width.equalTo(117)
        //            make.top.equalTo(arrowBottomLabel.snp.bottom).offset(18)
        //            make.bottom.equalTo(scrollView.snp.bottom)
        //        }
        //
        //        unfoldExplainStackView.snp.makeConstraints { make in
        //            make.height.equalTo(222)
        //            make.leading.equalTo(unfoldStackView.snp.trailing)
        //            make.trailing.equalTo(scrollView.safeAreaLayoutGuide).offset(-16)
        //            make.top.equalTo(arrowBottomLabel.snp.bottom).offset(18)
        //            make.bottom.equalTo(scrollView.snp.bottom)
        //        }
    }
}

extension MovieDetailView {
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.characterLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
}

extension MovieDetailView {
    private func characterLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)
            
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 4)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MovieDetailHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}

extension MovieDetailView {
    func changeIsHidden(isHidden: Bool) {
        unfoldStackView.isHidden = isHidden
        unfoldExplainStackView.isHidden = isHidden
        changeLayout(isHidden: isHidden)
    }
    
    func changeLayout(isHidden: Bool) {
        if isHidden == true {
            unfoldButton.snp.removeConstraints()
            unfoldButton.snp.remakeConstraints { make in
                make.top.equalTo(mbtiPreferContainView.snp.bottom).offset(36)
                make.bottom.equalTo(scrollView.snp.bottom)
                make.trailing.equalTo(scrollView.safeAreaLayoutGuide).offset(-20)
                make.width.equalTo(60)
            }
            unfoldStackView.snp.removeConstraints()
            unfoldExplainStackView.snp.removeConstraints()

        } else {
            unfoldButton.snp.removeConstraints()
            unfoldButton.snp.remakeConstraints { make in
                make.top.equalTo(mbtiPreferContainView.snp.bottom).offset(36)
                make.height.equalTo(19)
                make.trailing.equalTo(scrollView.safeAreaLayoutGuide).offset(-20)
                make.width.equalTo(60)
            }
            
            unfoldStackView.snp.removeConstraints()
            unfoldStackView.snp.remakeConstraints { make in
                make.height.equalTo(222)
                make.leading.equalTo(16)
                make.width.equalTo(117)
                make.top.equalTo(arrowBottomLabel.snp.bottom).offset(18)
                make.bottom.equalTo(scrollView.snp.bottom)
            }
            unfoldExplainStackView.snp.removeConstraints()
            unfoldExplainStackView.snp.remakeConstraints { make in
                make.height.equalTo(222)
                make.leading.equalTo(unfoldStackView.snp.trailing)
                make.trailing.equalTo(scrollView.safeAreaLayoutGuide).offset(-16)
                make.top.equalTo(arrowBottomLabel.snp.bottom).offset(18)
                make.bottom.equalTo(scrollView.snp.bottom)
            }
        }
        scrollView.layoutIfNeeded()

    }
}
