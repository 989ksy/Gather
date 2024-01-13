//
//  SignupViewModel.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import Foundation
import RxSwift
import RxCocoa

class SignupViewModel {
    
    let disposeBag = DisposeBag()
    
    //MARK: - 정규식
    
    //이메일 정규식 (@, .com 포함)
    let emailRegex = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}$"#
    
    //비밀번호 정규식
    let passwordRegex =  "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])(?=.*[0-9])[A-Za-z\\d$@$!%*?&]{8}"
    
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
        let closeButtonTapped: BehaviorRelay<Bool> //닫기버튼누름
    }
    
    func transform(input: Input) -> Output {
        
        //이메일 정규식 확인
        let emailValidation = input.emailText
            .map{
                $0.range(of: self.emailRegex,
                         options: .regularExpression) != nil
            }
        
        //이메일 중복 확인 네트워크
        
        let emailValidationCheck = PublishRelay<Bool>()
                
//        input.emailValidationTap
//            .throttle(.seconds(1), scheduler: MainScheduler.instance)
//            .withLatestFrom(input.emailText, resultSelector: { _, query in
//                return query
//            })
//            .map { query in
//                return "\(query)"
//            }
//            .flatMap { email in
//                Network.shared.requestEmail(email: email, router: .emailValidation(model: .init(email: email)))
//            }
//            .subscribe(with: self) { owner, result in
//                emailValidationCheck.accept(true)
//                print("----🎉 이메일 중복확인 성공")
//            }
//            .disposed(by: disposeBag)
        
        
        //닉네임 조건확인
        let nickValidation = input.nickText
            .map { $0.count > 0 && $0.count < 31 }
        
        //비밀번호 조건확인
        let passwordValidation = input.passwordText
            .map {
                $0.range(of: self.passwordRegex,
                         options: .regularExpression) != nil
            }
        
        //핸드폰 번호
        let phoneValidation = input.phoneNumbText
            .map{ 
                $0.count < 13 &&
                $0.range(
                    of: self.phoneRegex,
                    options: .regularExpression) != nil
            }
        
        //비밀번호 더블체크
        let passwordDoubleCheck = Observable.combineLatest(input.passwordText, input.passwordValidText) { pwText, checkText in
            
            return pwText == checkText && !pwText.isEmpty && !checkText.isEmpty
        }
        
        //닫기버튼 탭했을 때
        var closeButtonTapped = BehaviorRelay<Bool>(value: false)
        
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
            closeButtonTapped: closeButtonTapped
        )
    }
    
    
}
