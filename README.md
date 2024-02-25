# Gather

<img width="120" height="120" src="https://github.com/989ksy/Gather/assets/122261047/0be8047d-5ef0-43d6-add3-39be23eb12d2">

</br>
</br>

**💬 어디서나 팀을 모을 수 있는 그룹 채팅 어플리케이션**


## Preview

![Zickwan](https://github.com/989ksy/Gather/assets/122261047/d3bd0325-f2ae-45e9-8aa9-12621d74ed9f)


</br>

## 프로젝트

**개발기간** : 2023년 01월 03일 ~ 2023년 02월 19일

**개발인원**: 1인

**협업툴**: Swagger, Figma, Confluence

**iOS 최소 지원버전**: 16.0 이상

**Package Dependency Manager**: Swift Package Manager


</br>

## 특징

- 온보딩 제공
- 회원가입, 소셜 로그인, 이메일 로그인 
- 워크 스페이스 및 채널 생성 및 조회
- 워크 스페이스 및 채널에 다른 유저 초대
- 다인원 실시간 채팅
- 채팅 수신 시 Remote Push Notification 기능

</br>

## 스택

- `UIKit`, `CodeBaseUI`, `SnapKit`
- `Alamofire`, `Kingfisher`, `RxSWift`, `RxCocoa`, `Realm`, `SocketIO`
- `SwiftKeychainWrapper`, `Firebase(Messaging)`, `KakaoOpenSDK`
- `UISheetPresentation`, `SideMenu`, `Toast`
- `MVVM`, `Singleton`, `Input/Output`, `Repository Pattern`, `Router Pattern`

</br>

## 구현기능

- **AuthenticationServices**와 **Kakao SDK**를 사용하여 **애플과 카카오 소셜 로그인 기능**을 구현
- **UITapGestureRecognizer**와 **delegate 패턴**을 활용하여 **UI TableView 섹션 폴딩** 구현
- **SocketIO**를 기반으로 한 클라이언트와 서버 간의 양방향 통신을 통해 **실시간 채팅 기능**
- 읽은 메세지 내역을 **Realm Database**에 저장하여 불필요한 네트워크 통신 방지
- **Firebase Cloud Messaging**을 사용하여 **Remote Push Notification** 수신
- **Alamofire**의 **URLRequestConvertible**프로토콜을 이용해 **Router 패턴**으로 추상화
- **CustomView**를 통해 중복되는 UI 코드 간결화 및 재사용
- **RxSwift**와 **Input/Output**을 이용한 **MVVM** 아키텍처


</br>

 ## 트러블 슈팅

### 1. UI TableView 섹션 폴딩 구현

#### [문제사항]

HomeDefaultViewController의 TableView에서 채널과 다이렉트 메세지로 구분 된 section이 사용자의 액션에 따라 동적으로 표시되거나 숨겨져야 함.

- 고려해야 했던 사항:

  i. 여러 Section 상태(열림/닫힘) 관리

  ii. 사용자가 section header를 탭했을 때, 해당 section과 관련된 UI 업데이트


#### [해결방안]

i. Section 상태 관리

- 각 section의 열림/닫힘 상태를 관리하기 위해 상태 배열을 Bool로 만들어 사용. 각 섹션의 상태를 true (열림) 또는 false (닫힘)으로 저장함.

``` swift
//섹션의 초기 상태를 모두 닫힘으로 설정
var isOpen = [false, false, false]        
```

ii. 사용자 반응 처리
- HomeDefaultHeaderView 내에서 UITapGestureRecognizer를 추가하여 section header가 탭될 때마다 이벤트를 처리

``` swift
let tapGestureRecognizer = UITapGestureRecognizer()
tapGestureRecognizer.addTarget(self, action: #selector(didSelectSection))
layerView.addGestureRecognizer(tapGestureRecognizer)
            
```

iii. section 반응 처리
- 탭 이벤트가 발생하면 didSelectSection 메서드가 호출되어 해당 섹션의 상태를 토글하고 tableView를 업데이트

``` swift
@objc func didSelectSection() {
    delegate?.didTouchSection(self.sectionIndex)
    isOpened.toggle()
}

```

- HeaderViewDelegate 프로토콜을 통해 HomeDefaultViewController에 Section 탭 이벤트를 전달하고, VC에서는 didTouchSection 메서드를 구현하여 해당 seciton만을 다시 로드
  
``` swift
func didTouchSection(_ sectionIndex: Int) {
    viewModel.isOpen[sectionIndex].toggle()
    mainView.homeTableView.reloadSections([sectionIndex], with: .none)
}

```

iV. section headerView UI 업데이트

- section의 열림/닫힘 상태에 따라 UI 업데이트

``` swift
var isOpened: Bool = false {
    didSet {
        foldImageView.image = isOpened ? ConstantIcon.chevronDown : ConstantIcon.chevronUp
        dividerBottom.isHidden = !isOpened
    }
}

```
 

### 2. Socket 연결 및 해제 시점

#### [문제사항]

i. 사용자가 채팅 화면에서 채널 설정 화면으로 이동한 후 다시 채팅 화면으로 돌아올 때, 소켓 연결이 제대로 이루어지지 않아 실시간 채팅 불가

ii. 앱이 백그라운드 상태로 전환되었을 때, 소켓 연결이 유지되어 배터리 소모 및 불필요한 데이터 사용이 발생하는 문제

#### [문제해결]

i. viewWillAppear를 사용한 소켓 연결 재설정

- 소켓 연결 코드를 뷰 컨트롤러의 생명주기에서 한 번만 호출되는 viewDidLoad에서 뷰 컨트롤러가 화면에 나타날 때마다 호출되는 viewWillAppear로 이동시킴으로써, 사용자가 채팅 화면으로 돌아올 때마다 소켓 연결을 하도록 재설정.

``` swift

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // 소켓 열기
    SocketIOManager.shared.establishConnection(viewModel.channelId)
    
    // 소켓 데이터 디코딩
    listenToMessages()
    
}

```

ii. 백그라운드 상태에서 소켓 연결 관리를 통한 리소스 최적화

- SceneDelegate의 sceneDidEnterBackground 메서드를 활용하여 앱이 백그라운드 상태로 전환될 때 소켓 연결을 해제

``` swift

func sceneDidEnterBackground(_ scene: UIScene) {
    SocketIOManager.shared.isOpen = false
    SocketIOManager.shared.closeConnection()
}

```

- SceneDelegate의 sceneDidBecomeActive 메서드를 활용하여 앱이 다시 활성화될 때 소켓 연결을 재설정

``` swift

func sceneDidBecomeActive(_ scene: UIScene) {
    SocketIOManager.shared.isOpen = true
    NotificationCenter.default.post(name: NSNotification.Name("reconnectSocket"), object: nil)
}


```

- ChannelChattingViewController에서 NotificationCenter를 통해 발행된 소켓 재연결 이벤트를 감지하고, 해당 이벤트에 반응하여 소켓 연결을 다시 설정

``` swift

@objc func reconnectSocket() {
    SocketIOManager.shared.establishConnection(viewModel.channelId)
    listenToMessages()
}

```


 </br>

 ## 회고

* 이 프로젝트를 통해 SocketIO를 활용한 다인원 실시간 채팅 기능을 구현했습니다. 실시간 채팅 구현 과정에서 소켓 연결 시점 관리가 스스로에게 핵심 과제였습니다. 앱의 포그라운드 및 백그라운드 상태 변화를 캐치하기 위해 SceneDelegate의 생명주기를 적극 활용했지만, 네트워크 상태 변화에 따른 사용자 알림과 소켓 연결 끊김 처리에 있어 아쉬움이 남았습니다. 이 경험으로 실시간 통신의 복잡성, SocketIO의 활용, 이벤트 기반 통신의 이해, 그리고 효과적인 리소스 관리의 중요성을 깨달았습니다. 향후 프로젝트에서는 네트워크 상태 모니터링 기능을 강화하여 사용자가 네트워크 변화에 따라 적절한 피드백을 받을 수 있도록 개선할 계획입니다.
