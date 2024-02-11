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
        

        //MARK: - 로그인 + 화면전환

        
        //워크스페이스 생성 갯수가 0개
        output.goToEmpty
            .subscribe(with: self) { owner, value in
                
                if value {
                    
                    self.dismiss(animated: true)
                    
                    let vc = HomeEmptyViewController()
                    self.view.window?.rootViewController = vc
                    
                    print("--- ✅ EmailVC  -> empty 화면전환 성공")
                    
                } else {
                    
                    print("워크스페이스 0개인데 화면전환 못함~!")
                    
                }
                
            }
            .disposed(by: disposeBag)
        
        //워크스페이스 생성 갯수가 1개
        output.goToHomeDefault
            .subscribe(with: self) { owner, value in
                
                if value {
                    
                    self.dismiss(animated: true)
                    
                    let vc = UINavigationController(rootViewController: CustomTabbarViewController())
                    
                    vc.isNavigationBarHidden = true
                                        
                    self.view.window?.rootViewController = vc
                    
                    print("--- ✅EmailVC  -> HomeDefault 화면전환 성공")
                    
                } else {
                    
                    print("워크스페이스 있는데 홈화면 전환 못함~!")
                    
                }
                
            }
            .disposed(by: disposeBag)
        
        
        
        
    }
    
}
