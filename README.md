# DIMO : MVTI Project

### 적용 기술

| Skill     | Explain                                    |
| --------- | ------------------------------------------ |
| 아키텍쳐  | MVVM - C / Input - Output Pattern / Clean Architecture      |
| 네트워크  | URLSession / Router Pattern / Asnyc, Await |

### Code Convention

| Target   | Explain                              |
| -------- | ------------------------------------ |
| 함수     | 주어 + 동사 + 목적어                 |
| 변수     | Bool Type : is*** / 간결 + 직관적    |
| 네트워크 | 요청 : request ** / 응답 : respond** |

### Commit Convention

| Convention | Explain                             |
| ---------- | ----------------------------------- |
| [Feat]     | 새로운 기능 추가                    |
| [Fix]      | 버그 수정                           |
| [Design]   | UI 작업 변경                        |
| [Refactor] | 코드 리팩토링                       |
| [Comment]  | 주석 추가 및 변경                   |
| [Remove]   | 파일을 삭제하는 작업만 수행 한 경우 |
| [Setting]  | 기본 구성요소들을 작업한 경우|
| [Docs]   | Readme 수정작업                     |

### UI
<img width="1082" alt="스크린샷 2023-08-01 오후 8 34 28" src="https://github.com/SideProject-DIMO/iOS/assets/81552265/d72dda3d-4257-49c7-b848-fd0e6473b07f">

### Architecture 구성도

<img width="1082" alt="스크린샷 2023-09-14 오전 11 16 35" src="https://github.com/SideProject-DIMO/iOS/assets/81552265/44e37f9c-0a7b-40ce-a821-9d3ae86be726">

### 회고

**실제 출시 프로젝트에서의 Architecture에 대한 고찰**

- Figma 기준 View 개수 80개 이상, API 개수 70개 이상의 서비스
- 기획자 / 디자이너 / 안드로이드 / iOS / 서버 / 웹 으로 구성된 단체 협업 프로젝트
- Clean Architecture을 사용하면서 UseCase를 통한 ViewModel의 코드 재사용성 증가
- 다른 iOS 개발자가 구성한 Logic도 Layer 분리를 통해 빠른 코드 이해 및 적용 가능
- 초기 구현단계에서의 개발 속도는 낮아지지만, 추가 / 수정되는 Feature에 대한 유지보수성 및 개발 퍼포먼스 증가의 이점
- 서비스 규모에 따른 구조적 설계의 필요성 체감

**ViewModel에서의 DIP에 대한 고민**

- MVVM Pattern에서 DIP를 적용한 TestCode 작성
- View Builder / ViewModel Input / Output Protocol / ViewModel Protocol / ViewModel Impl의 추가 코드 작성 필요
- Testable의 관점에서는 용이하나, 실제 프로젝트에 전체 적용하기에는 개발 퍼포먼스 측면에서 과도한 제약 및 시간 소요가 된다고 판단
- 내부 iOS 개발자와 회의 후, 이 부분에서는 기존 MVVM 구조를 가져가기로 협의

**Coordinator 분리에 대한 고민**

- 4개의 Tabbar 영역의 Coordinator Flow로 각각의 화면 전환을 담당하는 구조로 구성
- 3번째 탭에서 1번째 탭의 화면으로 이동해야 하는 이슈 발생.
- 각 탭의 Coordinator에서 추가로 화면 Flow에 따른 Coordinator를 분리
- 다른 Coordinator에서도 필요한 화면 Flow에 따른 Coordinator에 Navigation을 주입시켜주는 방식으로 구조 변경
- 화면 전환에 대해 유연한 대처가 가능

**다양한 예외처리에 대한 고민**

- 게시글 / 댓글 / 스포일러 / 좋아요 여부에 따른 처리 등 다양한 화면에서의 예외처리 로직
- 다양한 예외처리에 대해 iOS 개발자와 논의 및 케이스 다이어그램 구성
- 직관적인 케이스 다이어그램으로 꼼꼼한 예외처리 적용

### 트러블 슈팅

## 1 네비게이션 바 이슈

## 1-1. 내비게이션 바

**참고 링크 : https://sarunw.com/posts/how-to-change-back-button-image/**

내비게이션바의 백버튼 쪽에서 지속적으로 이슈가 발생했습니다(어떤 페이지에선 백버튼 이미지와 타이틀이 안 사라지는 경우)

확인해보니 내비게이션 바에 대한 설정은 푸시된 뷰컨트롤러에서 하는 것이 아닌 푸시할 뷰컨트롤러에서 해줘야 됐었습니다… 

때문에 `BaseViewController`에 넣어둔 코드 때문에 그런게 아닐까 생각했고 이에대해 더 찾아보았습니다.([링크](https://sarunw.com/posts/how-to-change-back-button-image/))

위 링크에서 이에 대한 자료를 찾을 수 있었고 `SceneDelegate`에서 전역적으로 네비게이션바를 설정해주면 될 것 같다고 생각했습니다.

```swift
extension SceneDelegate {
    private func configureNavigationAppearance() {
        let backButtonImage = UIImage(named: "Icon_arrow_left")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImageㅏ적으
```

하지만 `UINavigationBarAppearance()`에선 백 버튼의 타이틀을 없애는 메소드나 프로퍼티는 제공해주지 않았습니다. 그래서 타이틀 없애는 코드를 `BaseViewController` 쪽에 따로 작성해줬습니다.(+ 백버튼 색)

```swift
func setNavigationBar() {
	  self.navigationController?.navigationBar.backItem?.title = ""
    self.navigationController?.navigationBar.topItem?.title = ""
    self.navigationController?.navigationBar.tintColor = .black60
}
```

그래서 기존엔 회원가입 및 로그인 하는 부분의 BackButton만 변경이 됐었는데…

내 정보 쪽에서도 적용이 된 걸 확인했습니다!!!

추가적으로 위 링크 들어가셔서 확인해보면 백버튼의 크기를 개발자가 조정하는게 아닌 것 으로 보입니다. 디자이너가 Asset Image 자체에 왼쪽 여백 값을 주면 여백만큼 백버튼의 너비가 조정되는 것으로 보이네요 🙂

## 2. Diffable Datasource에서 헤더에서 중첩 구독 문제 해결

Diffable Datasource에서 HeaderView에 버튼을 심어놓고, HeaderView를 등록하는 부분에서 접근하였을 때 구독이 중첩되어 해당 버튼을 클릭 시 여러 번 함수가 호출되는 문제가 발생하였습니다.

이유 : HeaderView의 재사용 문제

이전 코드

```swift
let cellHeroCharacterRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        mbtiHeroDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.mbtiHeroCharacterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellHeroCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
            
            supplementaryView.moreButton.rx.tap
                .debug()
                .bind { [weak self] _ in
                guard let self else { return }
                self.posterCellSelected.onNext(())
            }
            .disposed(by: self.disposeBag)
        }
        
        mbtiHeroDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            
            return header
        })
```

그 전에는 Home화면에서 데이터소스에 헤더뷰를 등록하는 과정에서 안에 버튼에 접근하여 구독을 실시했는데, 이런 상황에서 스크롤을 내리다보면 헤더 뷰 재사용이슈로 중첩 구독이 발생했습니다. 컬렉션 뷰 하나로 데이터 소스를 공유하는 상황이어서 이러한 문제점이 발생했다는 것을 이해하고 뷰 구조를 각각의 데이터 소스를 가지고 저장하도록 변경하였습니다.

그 후 각각의 헤더뷰의 버튼 위치에 뷰 계층구조에 따라 위에 투명 버튼을 올리고, headerView가 아닌 view에 접근해서 바로 버튼에 접근하도록 변경하였습니다.

HomeViewController

```swift
//MARK: 각각의 데이터소스를 설정
private var posterDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
private var characterDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
private var mbtiHeroDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
private var recommendDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!
private var nowHotDataSource: UICollectionViewDiffableDataSource<Int, AnimationData>!

//MARK: PosterDataSource 설정
extension HomeViewController {
    func setPosterDataSource() {
        let cellPosterRegistration = UICollectionView.CellRegistration<PosterCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        posterDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.posterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellPosterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let todayDIMOHeader = UICollectionView.SupplementaryRegistration<TodayDIMOHeaderView>(elementKind: TodayDIMOHeaderView.identifier) { supplementaryView, elementKind, indexPath in
        }
        
        posterDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: todayDIMOHeader, for: indexPath)
            return header
        })
    }
}

//MARK: MbtiHeroDataSource 설정
extension HomeViewController {
    func setMbtiHeroDataSource() {
        let cellHeroCharacterRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        mbtiHeroDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.mbtiHeroCharacterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellHeroCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
            
        }
        
        mbtiHeroDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            
            return header
        })
    }
}

//MARK: CharacterDataSource 설정
extension HomeViewController {
    func setCharacterDataSource() {
        let cellCharacterRegistration = UICollectionView.CellRegistration<CircleCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier.characters[0])
        }
        
        characterDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.characterCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellCharacterRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
        }
        
        characterDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            
            return header
        })
    }
}

//MARK: RecommendDataSource 설정
extension HomeViewController {
    func setRecommendDataSource() {
        let cellRecommendRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        recommendDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.recommendCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRecommendRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
        }
        
        recommendDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            
            return header
        })
    }
}

//MARK: NowHotDataSource 설정
extension HomeViewController {
    func setNowHotDataSource() {
        let cellNowHotRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, AnimationData> { cell, indexPath, itemIdentifier in
            cell.configureAttribute(with: itemIdentifier)
        }
        
        nowHotDataSource = UICollectionViewDiffableDataSource(collectionView: homeView.nowHotCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellNowHotRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        let myMomentumHeader = UICollectionView.SupplementaryRegistration<MyMomentumHeaderView>(elementKind: MyMomentumHeaderView.identifier) {  supplementaryView, elementKind, indexPath in
        }
        
        nowHotDataSource.supplementaryViewProvider = .some({ collectionView, elementKind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: myMomentumHeader, for: indexPath)
            
            return header
        })
    }
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch collectionView {
        case self.homeView.posterCollectionView:
                self.posterCellSelected.onNext(())
        case self.homeView.mbtiHeroCharacterCollectionView:
            self.mbtiMovieCellSelected.onNext(())
        case self.homeView.characterCollectionView:
            self.mbtiCharacterCellSelected.onNext(())
        case self.homeView.recommendCollectionView:
            self.mbtiRecommendCellSeleted.onNext(())
        case self.homeView.nowHotCollectionView:
            self.hotMovieCellSelected.onNext(())
        default:
            print("다른컬렉션뷰클릭함")
        }
    }
}
```

하나의 컬렉션 뷰가 아닌 5개의 컬렉션 뷰에 스크롤뷰로 넣어주는 형식으로 구현 방식을 변경하였고, 중첩 구독문제를 해결하였습니다.

## 3. 데이터에 따른 화면 분기처리

# 

각각의 섹션마다 데이터가 존재할 때에는 왼쪽처럼, 데이터가 없을때는 오른쪽 처럼 구현해야하는 디자인이었습니다.

위와 같은 상황에서 하나의 CollectionView로 구성한 화면 구조에서 각각의 컬렉션뷰로 총 4개의 컬렉션 뷰로 화면 구조를 변경하였고, 각각의 컬렉션뷰와 데이터가 없을 때 띄워줄 뷰를 함께 구성하여 스택뷰로 묶은 후, 스택뷰들을 전체 ScrollView로 감싸고 각각의 데이터에 따라 hidden처리를 해주는 방식으로 구현하였습니다.

```swift
class MyMomentumView: BaseView {
    
    lazy var containScrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(profileView)
        view.addSubview(profileStackView)
        view.addSubview(digStackView)
        view.addSubview(reivewStackView)
        view.addSubview(commentStackView)
        return view
    }()
    
    let profileView: ProfileView = {
        let view = ProfileView()
        return view
    }()
    
    lazy var profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createProfileLayout())
    lazy var digFinishCharacherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createDigFinishLayout())
    lazy var reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createReviewCommentLayout())
    lazy var commentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createReviewCommentLayout())
    
    lazy var profileStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(profileCollectionView)
        view.addArrangedSubview(exceptionHandlingLikeContentView)
        return view
    }()
    
    lazy var digStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(digFinishCharacherCollectionView)
        view.addArrangedSubview(exceptionHandlingDigView)
        return view
    }()
    lazy var reivewStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(reviewCollectionView)
        view.addArrangedSubview(exceptionHandlingReviewView)
        return view
    }()
    
    lazy var commentStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.addArrangedSubview(commentCollectionView)
        view.addArrangedSubview(exceptionHandlingCommentView)
        return view
    }()
    
    let exceptionHandlingLikeContentView: MyMomentumBaseExceptionHandlingView = {
        let view = MyMomentumBaseExceptionHandlingView(title: "좋아하는 컨텐츠", subtitle: "좋아하는 컨텐츠가 없어요")
        return view
    }()
    
    let exceptionHandlingDigView: MyMomentumDigExceptionHandlingView = {
        let view = MyMomentumDigExceptionHandlingView(title: "Dig 완료한 캐릭터", subtitle: "아직 기록이 없어요")
        return view
    }()
    
    let exceptionHandlingReviewView: MyMomentumBaseExceptionHandlingView = {
        let view = MyMomentumBaseExceptionHandlingView(title: "내가 쓴 리뷰", subtitle: "작성된 리뷰가 없어요")
        return view
    }()
    
    let exceptionHandlingCommentView: MyMomentumBaseExceptionHandlingView = {
        let view = MyMomentumBaseExceptionHandlingView(title: "내가 쓴 댓글", subtitle: "작성한 댓글이 없어요")
        return view
    }()
```

또한 이러한 뷰를 구성할 때 화면의 위치를 동적으로 설정하기 위해 lessThanOrEqualTo 및 remakeConstraints이라는 스냅킷 메서드를 사용하여 레이아웃을 분기처리에 따라 새로 잡아주도록 구성하였습니다.

Layout

```swift
override func setupLayout() {
        containScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(containScrollView.snp.top)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(350)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.lessThanOrEqualTo(240)
        }
        
        digStackView.snp.makeConstraints { make in
            make.top.equalTo(profileCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.lessThanOrEqualTo(240)
        }
        
        reivewStackView.snp.makeConstraints { make in
            make.top.equalTo(digFinishCharacherCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.lessThanOrEqualTo(240)
        }
        
        commentStackView.snp.makeConstraints { make in
            make.top.equalTo(reviewCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.lessThanOrEqualTo(240)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
    }
```

데이터에 따라 함수로 각각의 StackView의 Layout을 업데이트하도록 수정

```swift
extension MyMomentumView {
    func configureProfileUpdateUI(dataExist: Bool) {
        if dataExist {
            self.exceptionHandlingLikeContentView.isHidden = true
            updateProfileExistLayout()
        } else {
            self.exceptionHandlingLikeContentView.isHidden = false
            self.profileCollectionView.isHidden = true
        }
    }
}

extension MyMomentumView {
    func configureDigUpdateUI(dataExist: Bool) {
        if dataExist == true {
            self.exceptionHandlingDigView.isHidden = true
            updateDigExistLayout()
        } else {
            self.exceptionHandlingDigView.isHidden = false
            self.digFinishCharacherCollectionView.isHidden = true
        }
    }
}

extension MyMomentumView {
    func configureReviewUpdateUI(dataExist: Bool) {
        if dataExist == true {
            self.exceptionHandlingReviewView.isHidden = true
            updateReviewExistLayout()
        } else {
            self.exceptionHandlingReviewView.isHidden = false
            self.reviewCollectionView.isHidden = true
        }
    }
}

extension MyMomentumView {
    func configureCommentUpdateUI(dataExist: Bool) {
        if dataExist == true {
            self.exceptionHandlingCommentView.isHidden = true
            updateCommentExistLayout()
        } else {
            self.exceptionHandlingCommentView.isHidden = false
            self.commentCollectionView.isHidden = true
        }
    }
}

extension MyMomentumView {
    func updateProfileExistLayout() {
        self.profileStackView.snp.remakeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func updateDigExistLayout() {
        self.digStackView.snp.remakeConstraints { make in
            make.top.equalTo(profileCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func updateReviewExistLayout() {
        self.reivewStackView.snp.remakeConstraints { make in
            make.top.equalTo(digFinishCharacherCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        self.layoutIfNeeded()
    }
}

extension MyMomentumView {
    func updateCommentExistLayout() {
        self.commentStackView.snp.remakeConstraints { make in
            make.top.equalTo(reviewCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(containScrollView.safeAreaLayoutGuide)
            make.height.equalTo(240)
            make.bottom.equalTo(containScrollView.snp.bottom)
        }
        
        self.layoutIfNeeded()
    }
}
```

이렇게 각각의 메서드로 화면 구조를 변경해주니, 다른 컬렉션뷰에 영향을 주지 않고 데이터에 따라 각각의 뷰마다 레이아웃 문제 없이 변경되도록 구성할 수 있었습니다.

## 4. Coordinator Pattern에서 delegate로 값 전달 하는 법

Coordinator Pattern에서 값 전달 하기

먼저, 프로젝트에서 사용한 Coordinator는 뷰 모델에서 코디네이터를 가지고 있고, 한 개의 코디네이터만 가질 수 있도록 구성되어 있는 구조이다.

이전 값으로 델리게이트를 통해 값전달을 하기 위해선 다른 뷰모델을 가져와야 하는 상황이었는데, 이러한 상황에서 ViewModel → ViewModel 값 전달을 하는 방식이 아니라 ViewModel → Coordinator → ViewModel로 값 전달을 하도록 생각을 변경하였다.

1. 값을 전달해주는 ViewModel

먼저, 값을 전달해주는 ViewModel에서 프로토콜을 만들어 준다.

```swift
protocol sendPostReviewDelegate {
    func sendPostReview(character_id: Int)
}
```

그 후 내부 델리게이트 변수를 만들어 주었다.

```swift
var delegate: sendPostReviewDelegate?
```

마지막으로, 값을 전달할 character_id를 보내주는 코드를 작성하였다.

```swift
self.postReview
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { vm, postReview in
                vm.delegate?.sendPostReview(character_id: postReview.character_id)
                vm.coordinator?.dismissViewController()
            }
            .disposed(by: disposeBag)
```

delegate로 값을 보내주고, 코디네이터에서 화면을 dismiss 해주도록 구성했다.

1. 두 컨트롤러를 가지고 있는 Coordinator에서 델리게이트를 채택

내가 값 전달을 하려는 구조는 A → B 화면이 진행될 때, B에서 A 화면으로 dismiss될 때 값 전달이 일어나야 하는 구조였다. 

그래서 먼저 두 화면을 가지고 있는 코디네이터에게 델리게이트를 채택해주었다.

```swift
extension TabmanCoordinator: sendPostReviewDelegate {
    func sendPostReview(character_id: Int) {
        self.characterId.accept(character_id)
    }
}
```

그리고 값이 들어왔을 때 이벤트를 받을 변수를 코디네이터에 추가해주었다.

```swift
var characterId = PublishRelay<Int>()
```

그 후, B 화면에서 델리게이트를 가지도록 연결해주었다.

```swift
func showWriteViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterUseCaseImpl = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let viewModel = WriteViewModel(coordinator: self, characterDetailUseCase: characterUseCaseImpl, characterId: character.character_id)
        viewModel.delegate = self
        let vc = WriteViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
```

1. 마지막으로 뷰컨에서 DI를 통해 위 스트림을 가지도록 해주고, 뷰 모델에 코디네이터에서 가지고 있는 데이터 값을 넣어주었다.

A화면의 ViewModel init 구문

```swift
init(coordinator: TabmanCoordinator? = nil, characterDetailUseCase: CharacterDetailUseCase, character: Characters?, characterId: PublishRelay<Int>) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.character = BehaviorRelay<Characters?>(value: character)
        self.characterId = characterId
    }
```

A화면의 초기화 시점의 init 구문

```swift
init(viewModel: CharacterDetailViewModel) {
    self.viewModel = viewModel
      let dataTransferService = DataTransferService(networkService: NetworkService())
      let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
      let characterDetailUseCaseImpl = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
      let feedViewModel = FeedViewModel(coordinator: viewModel.coordinator, characterDetailUseCase: characterDetailUseCaseImpl, character: viewModel.coordinator?.character, characterId: viewModel.coordinator?.characterId ?? PublishRelay<Int>())
    
    vc1 = .init(viewModel: feedViewModel)
    vc2 = .init()
    
    vcs = .init([vc1, vc2])
    
    super.init(nibName: nil, bundle: nil)
  }
```

한계점

Coordinator에서 Rx를 import하는 방법이 좋은 방법인가에 대한 고찰이 필요할 것 같습니다.
