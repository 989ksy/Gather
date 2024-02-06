//
//  SignupViewModel.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import Foundation
import RxSwift
import RxCocoa

class SignupViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    //MARK: - 정규식
    
    //이메일 정규식 (@, .com 포함)
    let emailRegex = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}$"#
    
    //비밀번호 정규식
    let passwordRegex =  "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}$"
    
    //핸드폰번호 정규식
    let phoneRegex = "/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/"
    
    //MARK: - Input & Output
    
    struct Input {
        let closeButtonTap: ControlEvent<Void> //닫힘버튼
        let emailText: ControlProperty<String> //이메일작성
        let emailValidationTap: ControlEvent<Void> //중복확인버튼
        let signupTap: ControlEvent<Void>
        
        let nickText: ControlProperty<String> //닉네임
        let phoneNumbText: ControlProperty<String>//전화번호
        let passwordText: ControlProperty<String>//비밀번호
        var passwordValidText: ControlProperty<String>//비밀번호 확인
    }
    
    struct Output {
        let emailValidation: Observable<Bool> //이메일 정규식확인
        let nickValidation: Observable<Bool>
        let phoneValidation: Observable<Bool>
        let passwordValidation: Observable<Bool>
        let passwordCheckValidation: Observable<Bool>
        let emailValidationCheck: PublishRelay<Bool>
        
        let isValidForSignup: Observable<Bool>
        
        let closeButtonTapped: BehaviorRelay<Bool> //닫기버튼누름
        let signUpButtonTapped: BehaviorRelay<Bool>// 가입하기 버튼 누름
    }
    
    func transform(input: Input) -> Output {
        
        //MARK: - 이메일
        
        //조건: @와 .com 포함
        let emailValidation = input.emailText
            .map{
                $0.range(of: self.emailRegex,
                         options: .regularExpression) != nil
            }
        
        //이메일 중복 확인 네트워크
        let emailValidationCheck = PublishRelay<Bool>()
        
        input.emailValidationTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.emailText, resultSelector: { _, query in
                return query
            })
            .map { query in
                return "\(query)"
            }
            .flatMap{
                Network.shared.requestEmptyResponse(router: .emailValidation(model: EmailValidationInput(email: $0)))
            }
            .subscribe(with: self) { owner, result in
                emailValidationCheck.accept(true)
                print("----🎉 이메일 중복확인 성공")
            }
            .disposed(by: disposeBag)
        
        //MARK: - 닉네임
        
        //조건: 최소 1글자 최대 30글자
        let nickValidation = input.nickText
            .map { $0.count > 0 && $0.count < 31 }
        
        
        //MARK: - 비밀번호
        
        //조건: 최소 8자 이상, 하나 이상의 대문자, 소문자, 숫자, 특수문자
        let passwordValidation = input.passwordText
            .map {
                $0.range(of: self.passwordRegex,
                         options: .regularExpression) != nil && $0.count >= 8
            }
        
        //비밀번호 더블체크
        let passwordDoubleCheck = Observable.combineLatest(input.passwordText, input.passwordValidText) { pwText, checkText in
            
            return pwText == checkText && !pwText.isEmpty && !checkText.isEmpty
        }
        
        //MARK: - 연락처 번호
        
        //핸드폰 번호
        let phoneValidation = input.phoneNumbText
            .map{
                $0.count < 13 &&
                $0.range(
                    of: self.phoneRegex,
                    options: .regularExpression) != nil
            }
        
        //MARK: - 가입하기
        
        // 가입조건 충족?
        //(기본: 빈값 X)
        let isSignupAvailable = Observable.combineLatest(
            input.emailText,
            input.nickText,
            input.passwordText,
            input.passwordValidText
        ) { (email, nick, pw, pwCheck) in
            if !email.isEmpty && !nick.isEmpty && !pw.isEmpty && !pwCheck.isEmpty {
                return true
            } else {
                return false
            }
        }
        
        let signupButtonTapped = BehaviorRelay<Bool>(value: false)
        
        //가입하기 탭했을 때
        input.signupTap
            .throttle(.seconds(3), latest: false, scheduler: MainScheduler.instance)
            .withLatestFrom (
                Observable.combineLatest(
                    input.emailText,
                    input.passwordText,
                    input.nickText,
                    input.phoneNumbText
                )
            )
            .flatMapLatest { email, password, nickname, phone in
                Network.shared.requestSingle(
                    type: SignupResponse.self,
                    router: .join(
                        model: .init(
                            email: email,
                            password: password,
                            nickname: nickname,
                            phone: phone,
                            deviceToken: ""
                        )
                    )
                )
            }
            .subscribe(with: self) { owner, result in
                
                switch result {
                    
                case .success(let response):
                    
                    signupButtonTapped.accept(true)
                    
                    KeychainStorage.shared.userID = "\(response.userID)"
                    KeychainStorage.shared.userToken = response.token.accessToken
                    KeychainStorage.shared.userRefreshToken = response.token.refreshToken
                    KeychainStorage.shared.userNickname = response.nickname

                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        
        //닫기버튼 탭했을 때
        let closeButtonTapped = BehaviorRelay<Bool>(value: false)
        
        input.closeButtonTap
            .subscribe(with: self) { owner, _ in
                closeButtonTapped.accept(true)
            }
            .disposed(by: disposeBag)
        
        
        return Output(
            emailValidation: emailValidation,
            nickValidation: nickValidation,
            phoneValidation: phoneValidation,
            passwordValidation: passwordValidation,
            passwordCheckValidation: passwordDoubleCheck,
            emailValidationCheck: emailValidationCheck,
            isValidForSignup: isSignupAvailable,
            closeButtonTapped: closeButtonTapped,
            signUpButtonTapped: signupButtonTapped
        )
    }
    
    
}
