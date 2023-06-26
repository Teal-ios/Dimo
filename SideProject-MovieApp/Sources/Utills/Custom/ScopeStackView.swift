//
//  ScopeStackView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import UIKit
import SnapKit
// UI
final class ScopeStackView: UIStackView {
    
    lazy var ratingStarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
      }()
    
    private var starImageViews: [UIImageView] = []
    
    lazy var ratingSlider: TapUISlider = {
        let slider = TapUISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 5 // 최대값
        slider.minimumValue = 0 // 최소값
            // 실제로 slider는 사용자 눈에 보이지 않을 것이므로 모든 컬러는 clear로 설정
        slider.maximumTrackTintColor = .clear
        slider.minimumTrackTintColor = .clear
        slider.thumbTintColor = .clear
        slider.addTarget(self, action: #selector(tapSlider(_:)), for: .valueChanged)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.addSubview(ratingStarStackView)
        self.addSubview(ratingSlider)

        ratingStarStackView.snp.makeConstraints { make in
            make.edges.equalTo(ratingSlider)
        }
        ratingSlider.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
    }
}

// 반복문을 이용하여 Stack View에 별 Image View 추가
extension ScopeStackView {
    func setRatingImageView() {
        for index in 0..<5 {
          let imageView = UIImageView()
          imageView.image = UIImage(named: "ic_rating_off")
          imageView.tag = index
          ratingStarStackView.addArrangedSubview(imageView)
          starImageViews.append(ratingStarStackView.subviews[index] as? UIImageView ?? UIImageView())
        }
    }
    
    // 이 함수가 아주아주 중요하다!
    @objc func tapSlider(_ sender: UISlider) {
            // 슬라이더의 값을 올림 하여 받아옴 (사이에서 멈출 때는 더 큰 수에 반응)
        var intValue = Int(ceil(sender.value))
        
        for index in 0..<5 {
          if intValue == 1 {
            intValue -= 1 // index에 맞추기 위해 -1
            starImageViews[index].image = UIImage(named: "ic_rating_on_white")
          } else if index < intValue { // intValue 보다 작은 건 칠하기
            starImageViews[index].image = UIImage(named: "ic_rating_on_white")
          } else { // intValue 보다 크면 빈 별 처리
            starImageViews[index].image = UIImage(named: "ic_rating_off")
          }
       }
    }
}



