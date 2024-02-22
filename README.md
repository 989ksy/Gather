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
- **Custom HeaderView**와 **delegate 패턴**을 활용하여 **UI TableView 섹션 폴딩** 구현
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

고려해야 했던 사항:

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

- HeaderViewDelegate 프로토콜을 통해 HomeDefaultViewController Section 탭 이벤트를 전달하고, VC에서는 didTouchSection 메서드를 구현하여 해당 seciton만을 다시 로드
  
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
 

### 2. Realm?

#### [문제사항]



#### [문제해결]


``` swift



```


 </br>

 ## 회고
