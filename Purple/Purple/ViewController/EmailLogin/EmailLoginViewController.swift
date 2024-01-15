//
//  EmailLoginViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/14/24.
//

import UIKit
import RxSwift
import RxCocoa

import Toast

class EmailLoginViewController: BaseViewController {
    
    let mainView = EmailLoginView()
    let viewModel = EmailLoginViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
    }
    
    
    func bind() {
        
        let input = EmailLoginViewModel.Input(
            emailText: 
                mainView.emailTextField.rx.text.orEmpty,
            passwordText:
                mainView.passwordTextField.rx.text.orEmpty,
            loginTap: 
                mainView.logInButton.rx.tap,
            closeTap: 
                mainView.closeButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        
        //MARK: - 로그인조건 확인 (이메일 + 비밀번호 -> 버튼 가능)
        output.loginValidation
            .bind(to: mainView.logInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.loginValidation
            .subscribe(with: self) { owner, value in
                owner.mainView.logInButton.backgroundColor = value ? .brandPurple: .brandInactive
                
            }
            .disposed(by: disposeBag)
        

        //MARK: - 로그인
        
        output.isLoggined
            .subscribe(with: self) { owner, value in
                
                if value {
                    
                    self.dismiss(animated: true)
                    
                    let vc = HomeEmptyViewController()
                    self.view.window?.rootViewController = vc
                    
                } else {
                    
                    print("이메일 또는 비밀번호가 올바르지 않습니다.")
//                    self.setToastAlert(message: "이메일 또는 비밀번호가 올바르지 않습니다.")
                    
                }
            }
            .disposed(by: disposeBag)
        
        
        
        
//        output.isEmailWrong
//            .subscribe(with: self) { owner, value in
//                if value == false {
//                    self.setToastAlert(message: "이메일 형식이 올바르지 않습니다.")
//                    owner.mainView.emailTitleLabel.textColor = .red
//                }
//            }
//            .disposed(by: disposeBag)
//        
//        output.isPasswordWrong
//            .subscribe(with: self) { owner, value in
//                if value == false {
//                    self.setToastAlert(message: "비밀번호는 최소 8자 이상,\n하나 이상의 대소문자/숫자/특수 문자를 설정해주세요.")
//                    owner.mainView.emailTitleLabel.textColor = .red
//                }
//            }
//            .disposed(by: disposeBag)
        
        
        
        
        
    }
    
    
    
    
    
    
}
