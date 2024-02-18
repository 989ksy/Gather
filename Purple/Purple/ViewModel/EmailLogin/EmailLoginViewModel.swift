//
//  EmailLoginViewModel.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/14/24.
//

import Foundation

import RxSwift
import RxCocoa

final class EmailLoginViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    var workspaceID: Int?
    
    //이메일 정규식
    //(@, .com 포함)
    let emailRegexCom = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$"#
    
    //(@, co.kr 포함)
    let emailRegexCoKr = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.(co\.kr)$"#
    
    //(@, .net 포함)
    let emailRegexNet = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$"#
    
    //비밀번호 정규식
    let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$"#
    
    
    struct Input {
        
        let emailText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        let loginTap: ControlEvent<Void>
        let closeTap: ControlEvent<Void>
        
    }
    
    struct Output {
        
        let isEmailWrong: Observable<Bool>
        let isPasswordWrong: Observable<Bool>
        let loginValidation: Observable<Bool> //로그인 조건 부합?
        
        let goToEmpty: BehaviorSubject<Bool> //empty화면으로 가
        let goToHomeDefault: BehaviorSubject<Bool>
        
        let loginButtonTapped: BehaviorSubject<Bool>
        let closeButtonTapped: BehaviorSubject<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        
        //이메일 유효성 검증
        let emailValidation = input.emailText.map { email in
            return email.range(
                of: self.emailRegexCom,
                options: .regularExpression
            ) != nil ||
            email.range(
                of: self.emailRegexCoKr,
                options: .regularExpression
            ) != nil ||
            email.range(
                of: self.emailRegexNet,
                options: .regularExpression
            ) != nil
        }
        
        // 비밀번호 유효성 검증
        let passwordValidation = input.passwordText.map { password in
            return password.range(of: self.passwordRegex, options: .regularExpression) != nil
        }
        
        //로그인 validation
        let loginValidation = Observable.combineLatest(input.emailText, input.passwordText) { email, password in
            
            let isEmailValid = email.range(
                of: self.emailRegexCoKr,
                options: .regularExpression) != nil ||
            email.range(
                of: self.emailRegexCom,
                options: .regularExpression) != nil ||
            email.range(
                of: self.emailRegexNet,
                options: .regularExpression) != nil
            
            let isPasswordValid = password.range(
                of: self.passwordRegex,
                options: .regularExpression) != nil
            
            return isEmailValid && isPasswordValid
        }
        
        //로그인하기 버튼
        let loginButtonTapped = BehaviorSubject(value: false)
        
        let goToHomeEmpty = BehaviorSubject(value: false) //워크스페이스 0개 일 경우
        let goToHomeDefault = BehaviorSubject(value: false)// 워크스페이스 여러개일 경우
        
        let loginValue = Observable.combineLatest(input.emailText, input.passwordText).map { userInput in
            return userInput
        }
        
        input.loginTap
            .throttle(
                .seconds(2),
                latest: false,
                scheduler: MainScheduler.instance
            )
            .withLatestFrom(loginValue)
            .flatMap { userInput in
                Network.shared.requestSingle(
                    type: EmailLoginResponse.self,
                    router: .emailLogin(
                        model: .init(
                            email: userInput.0,
                            password: userInput.1,
                            deviceToken: UserDefaults.standard.string(forKey: "firebaseToken") ?? ""
                        )
                    )
                )}
            .filter { response in
                
                switch response {
                case .success(let result):
                    
                    KeychainStorage.shared.userToken = result.token.accessToken
                    KeychainStorage.shared.userRefreshToken = result.token.refreshToken
                    KeychainStorage.shared.userID = "\(result.userID)"
                                        
                    print("-----로그인 성공")
                    print("-----userToken 저장:",KeychainStorage.shared.userToken)
                    print("-----")
                    
                    return true
                    
                case .failure(let error):
                    print("----로그인 실패", error)
                    
                    return false
                }
                
            }
            .flatMapLatest({
                result in
                Network.shared.requestSingle(
                    type: [createWorkSpaceResponse].self,
                    router: .readAllMyWorkSpace
                )
            })
            .subscribe(with: self) { owner, result in
                print("--- 로그인은 일단 성공, 그런데 어디로 전환?")
                
                switch result {
                    
                case .success(let response):
                    
                    if response.isEmpty{
                        
                        goToHomeEmpty.onNext(true)
                        
                        print("--- empty 화면으로 전환")
                        
                    } else {
                        
                        goToHomeDefault.onNext(true)
                        
                        print("--- 홈디폴트", response)
                        
                        var latestWorkspaceID: Int? //가장 최신 id값
                        var latestDate: Date? //가장 최신 날짜
                                                
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        
                        for item in response {
                            
                            let createdAtString = item.createdAt
                            let createdAt = dateFormatter.date(from: createdAtString)
                            
                            if latestDate == nil || createdAt! > latestDate! {
                                
                                latestDate = createdAt
                                latestWorkspaceID = item.workspaceID
                                
                                UserDefaults.standard.setValue(latestWorkspaceID, forKey: "workspaceID")
                                
                                self.workspaceID = latestWorkspaceID
                            }
                            
                        }
                        
                        print("---- 홈디폴트로 전환, 최신 워크스페이스 ID:", latestWorkspaceID)
                    }
                    
                    
                case .failure(let error):
                    
                    print("-----------다 실패ㅠㅠ")
                    print("errorCode: ", error.errorCode )
                    print("statusCode: ", error.statusCode )
                }
                
            }
            .disposed(by: disposeBag)
        
        
        //닫기 버튼
        let closeButtonTapped = BehaviorSubject(value: false)
        
        input.closeTap
            .subscribe(with: self) { owner, _ in
                closeButtonTapped.onNext(true)
            }
            .disposed(by: disposeBag)
        
        
        return Output(isEmailWrong: emailValidation,
                      isPasswordWrong: passwordValidation,
                      loginValidation: loginValidation,
                      goToEmpty: goToHomeEmpty,
                      goToHomeDefault: goToHomeDefault,
                      loginButtonTapped: loginButtonTapped,
                      closeButtonTapped: closeButtonTapped)
    }
    
    
}
