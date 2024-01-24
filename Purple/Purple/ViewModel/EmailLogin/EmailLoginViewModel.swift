//
//  EmailLoginViewModel.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/14/24.
//

import Foundation

import RxSwift
import RxCocoa

class EmailLoginViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
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
        
        let isLoggined: BehaviorSubject<Bool> //로그인 가능?
        
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
            
            print("Email Valid: \(isEmailValid), Password Valid: \(isPasswordValid)")
            print("password: \(password)")
            
            return isEmailValid && isPasswordValid
        }
        
        //로그인하기 버튼
        let loginButtonTapped = BehaviorSubject(value: false)
        let isLoggined = BehaviorSubject(value: false)
        
        let loginValue = Observable.combineLatest(input.emailText, input.passwordText).map { userInput in
            return userInput
        }
        
        input.loginTap
            .throttle(.seconds(2), latest: false, scheduler: MainScheduler.instance)
            .withLatestFrom(loginValue)
            .flatMap { userInput in
                Network.shared.requestSingle(
                    type: EmailLoginResponse.self,
                    router: .emailLogin(
                        model: .init(
                            email: userInput.0,
                            password: userInput.1,
                            deviceToken: ""
                        )
                    )
                )
            }
            .subscribe(with: self) { owner, response in
                switch response {
                case .success(let result):
                    
                    isLoggined.onNext(true)
                    
                    KeychainStorage.shared.userToken = result.token.accessToken
                    KeychainStorage.shared.userID = "\(result.userID)"
                    
                    
                    print("-----")
                    print(KeychainStorage.shared.userToken)
                    print("-----")
                    
                case .failure(let error):
                    print(error)
                    
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
                      isLoggined: isLoggined,
                      loginButtonTapped: loginButtonTapped,
                      closeButtonTapped: closeButtonTapped)
        
    }
    
    
}
