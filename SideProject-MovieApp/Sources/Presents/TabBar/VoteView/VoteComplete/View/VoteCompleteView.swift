//
//  VoteCompleteView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/05.
//

import UIKit
import SnapKit

final class VoteCompleteView: BaseView {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(characterImageView)
        view.addSubview(characterNicknameLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(characterSelectButton)
        view.addSubview(voteChartContainView)
        view.addSubview(mbtiChartStackView)
        view.addSubview(manyPersonThinkingMbtiContainView)
        view.addSubview(manyPersonThinkingMbtiImageView)
        view.addSubview(manyPersonThinkingMbtiLabel)
        view.addSubview(choiceMbtiExplainContainView)
        view.addSubview(choiceMbtiExplainImageView)
        view.addSubview(choiceMbtiExplainLabel)
        view.addSubview(characterMoreCollectionView)
        return view
    }()
    
    lazy var characterMoreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCharacterLayout())
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white100
        label.font = Font.title1
        label.text = "투표 결과"
        return label
    }()
    
    let characterImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white100
        return view
    }()
    
    let characterNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle2
        label.textColor = .black5
        label.textAlignment = .center
        label.text = "정대만"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.textAlignment = .center
        label.text = "더 퍼스트 슬램덩크"
        return label
    }()
    
    let characterSelectButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let voteChartContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    lazy var mbtiChartStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eiChartView, nsChartView, tfChartView, jpChartView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.backgroundColor = .black90
        return stackView
    }()
    
    let manyPersonThinkingMbtiContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let manyPersonThinkingMbtiImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Badge")
        return view
    }()
    
    let manyPersonThinkingMbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
//        label.text = "많은 사람들이 ENTP라고 답변했어요"
        return label
    }()
    
    let choiceMbtiExplainContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    let choiceMbtiExplainImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "spoilerCheckOn")
        return view
    }()
    
    let choiceMbtiExplainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
//        label.text = "나를 비롯한 00%가 ESFP를 골랐어요"
        return label
    }()
    
    let eiChartView: WidthChartView = {
        let view = WidthChartView(mbtiPercent: 40, leftMbtiText: "E", rightMbtiText: "I")
        view.backgroundColor = .clear
        return view
    }()
    
    let nsChartView: WidthChartView = {
        let view = WidthChartView(mbtiPercent: 10, leftMbtiText: "N", rightMbtiText: "S")
        view.backgroundColor = .clear
        return view
    }()
    
    let tfChartView: WidthChartView = {
        let view = WidthChartView(mbtiPercent: 80, leftMbtiText: "T", rightMbtiText: "F")
        view.backgroundColor = .clear
        return view
    }()
    
    let jpChartView: WidthChartView = {
        let view = WidthChartView(mbtiPercent: 60, leftMbtiText: "J", rightMbtiText: "P")
        view.backgroundColor = .clear
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 109 / 2
        voteChartContainView.layer.cornerRadius = 8
        manyPersonThinkingMbtiContainView.layer.cornerRadius = 8
        choiceMbtiExplainContainView.layer.cornerRadius = 8
    }
    
    override func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(scrollView)
    }
    
    override func setupAttributes() {
        self.characterMoreCollectionView.isScrollEnabled = false
        
    }
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(36)
            make.centerX.equalTo(scrollView)
            make.width.height.equalTo(109)
        }
        
        characterNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(16)
            make.centerX.equalTo(characterImageView)
            make.height.equalTo(19)
            make.horizontalEdges.equalTo(scrollView).inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterNicknameLabel.snp.bottom).offset(4)
            make.centerX.equalTo(characterImageView)
            make.height.equalTo(16)
            make.horizontalEdges.equalTo(scrollView).inset(16)
        }
        
        characterSelectButton.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(characterImageView)
            make.bottom.equalTo(subtitleLabel.snp.bottom)
        }
        
        voteChartContainView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(36)
            make.horizontalEdges.equalTo(scrollView).inset(16)
            make.height.equalTo(288)
        }
        
        mbtiChartStackView.snp.makeConstraints { make in
            make.edges.equalTo(voteChartContainView).inset(24)
        }
        
        manyPersonThinkingMbtiContainView.snp.makeConstraints { make in
            make.top.equalTo(voteChartContainView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(scrollView).inset(16)
            make.height.equalTo(56)
        }
        
        manyPersonThinkingMbtiImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(manyPersonThinkingMbtiContainView).inset(16)
            make.width.equalTo(24)
        }
        
        manyPersonThinkingMbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(manyPersonThinkingMbtiImageView.snp.trailing).offset(8)
            make.centerY.equalTo(manyPersonThinkingMbtiContainView)
            make.height.equalTo(24)
            make.trailing.equalTo(manyPersonThinkingMbtiContainView.snp.trailing).offset(-16)
        }
        
        choiceMbtiExplainContainView.snp.makeConstraints { make in
            make.top.equalTo(manyPersonThinkingMbtiContainView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(scrollView).inset(16)
            make.height.equalTo(56)
        }
        
        choiceMbtiExplainImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(choiceMbtiExplainContainView).inset(16)
            make.width.equalTo(24)
        }
        
        choiceMbtiExplainLabel.snp.makeConstraints { make in
            make.leading.equalTo(choiceMbtiExplainImageView.snp.trailing).offset(8)
            make.centerY.equalTo(choiceMbtiExplainImageView)
            make.height.equalTo(24)
            make.trailing.equalTo(choiceMbtiExplainContainView.snp.trailing).offset(-16)
        }
        
        
        characterMoreCollectionView.snp.makeConstraints { make in
            make.top.equalTo(choiceMbtiExplainContainView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(scrollView)
            make.height.equalTo(280)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    
    private let itemRatio = 1.0
    private let groupRatio = 0.93
    private let headerRatio = 1.0
    private let headerAbsolute = 40.0
}

extension VoteCompleteView {
    private func createCharacterLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            default: return self.characterLayout()
            }
        }, configuration: configuration)
        return collectionViewLayout
    }
    
    private func characterLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio / 3),
            heightDimension: .fractionalHeight(itemRatio)
            
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 4, bottom: 12, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(headerRatio),
            heightDimension: .absolute(headerAbsolute)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MyMomentumHeaderView.identifier, alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered /// Set Scroll Direction
        return section
    }
}

extension VoteCompleteView {
    func configureUpdateCharacterInfo(with item: CharacterInfo) {
        self.characterNicknameLabel.text = item.character_name
        guard item.title != nil else { return }
        self.subtitleLabel.text = item.title
        let imageURL = URL(string: item.character_img)
        self.characterImageView.kf.setImage(with: imageURL)
    }
}

extension VoteCompleteView {
    func configureUpdateVoteCharacter(with item: VoteCharacter) {
        self.eiChartView.updateLayoutToMbtiPercent(percent: Double(item.mbti_percent?.ei ?? 50))
        self.nsChartView.updateLayoutToMbtiPercent(percent: Double(item.mbti_percent?.sn ?? 50))
        self.tfChartView.updateLayoutToMbtiPercent(percent: Double(item.mbti_percent?.tf ?? 50))
        self.jpChartView.updateLayoutToMbtiPercent(percent: Double(item.mbti_percent?.jp ?? 50))
        
    }
}

extension VoteCompleteView {
    func configureUpdateChart(with item: InquireVoteResult) {
        for ele in item.mbti_percent {
            switch ele.mbti {
            case "E":
                print(ele.ei ?? 0, "ei")
                eiChartView.updateLayoutToMbtiPercent(percent: Double(ele.ei ?? 50))
            case "N":
                print(ele.sn ?? 0, "ns")
                nsChartView.updateLayoutToMbtiPercent(percent: Double(ele.sn ?? 50))
            case "T":
                print(ele.tf ?? 0, "tf")
                tfChartView.updateLayoutToMbtiPercent(percent: Double(ele.tf ?? 50))
            case "P":
                print(ele.jp ?? 0, "jp")
                jpChartView.updateLayoutToMbtiPercent(percent: Double(ele.jp ?? 50))
            default:
                print("이건뭐징")
            }
        }
    }
    
    func configureUpdateMbtiContent(with item: InquireVoteResult) {
        if item.most_vote_mbti == nil {
            guard let percent = item.same_vote_percent else { return }
            guard let mbti = item.content_info.character_mbti else { return }
            guard let myChoiceMbti = item.my_vote_mbti else { return }
            
            let mainText = "많은 사람들이 \(mbti)라고 답변했어요"
            let attributeMbtiText = NSMutableAttributedString(string: mainText)
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black5,
            ]
            let mbtiRange = (mainText as NSString).range(of: mbti)
            attributeMbtiText.addAttributes(attributes, range: mbtiRange)

            self.manyPersonThinkingMbtiLabel.attributedText = attributeMbtiText
            self.choiceMbtiExplainLabel.text = "나를 비롯한 \(String(percent))%가 \(myChoiceMbti)를 골랐어요"
        }
    }
}
