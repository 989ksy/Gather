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
    
    //이메일 정규식
    let emailRegex = #"^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}$"#
    
    struct Input {
        let closeButtonTap: ControlEvent<Void> //닫힘버튼
        let emailText: ControlProperty<String> //이메일작성
        let emailValidationTap: ControlEvent<Void> //중복확인버튼
        
        let nickText: ControlProperty<String> //닉네임
        let phoneNumbText: ControlProperty<String>//전화번호
        let passwordText: ControlProperty<String>//비밀번호
        let passwordValidText: ControlProperty<String>//비밀번호 확인
    }
    
    struct Output {
        let emailValidation: Observable<Bool>
//        let nickValidation: Observable<Bool>
//        let passwordValidation: Observable<Bool>
//        let passwordCheckValidation: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        //이메일 정규식 확인
        let emailValidation = input.emailText
            .map{ $0.range(of: self.emailRegex, options: .regularExpression) != nil}
        
        return Output(emailValidation: emailValidation)
    }
    
    
}
