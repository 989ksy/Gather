//
//  AuthViewController.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

import RxSwift
import RxCocoa

import Toast

final class AuthViewController: BaseViewController, UISheetPresentationControllerDelegate {
    
    let mainView = AuthView()
    let viewModel = AuthViewModel()
    let disposeBag = DisposeBag()
    
    var oauthToken: String?
    var deviceToken: String?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindVM()
        
    }
    
    
    func bindVM() {
        
        let input = AuthViewModel.Input(
            singupTap: mainView.signUpButton.rx.tap,
            kakaoTap: mainView.kakaoLoginButton.rx.tap,
            appleTap: mainView.appleLoginButton.rx.tap, 
            emailTap: mainView.emailLoginButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        //로그인 버튼 tap
        //로그인화면으로 화면전환
        output.loginTapped
            .subscribe(with: self) { owner, value in
                if value {
                    let vc = EmailLoginViewController()
                    vc.modalPresentationStyle = .pageSheet
                    
                    if let sheet = vc.sheetPresentationController {
                        sheet.detents = [.large()]
                        sheet.delegate = self
                        sheet.prefersGrabberVisible = true
                    }
                    
                    self.present(vc, animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
        
        
        // 회원가입 버튼 tap
        // 회원가입 화면으로 화면전환
        output.signupTapped
            .subscribe(with: self) { owner, value in
                
                if value {
                    
                    let vc = SignupViewController() //회원가입VC
                    vc.modalPresentationStyle = .pageSheet
                    
                    if let sheet = vc.sheetPresentationController {
                        sheet.detents = [.large()]
                        sheet.delegate = self
                        sheet.prefersGrabberVisible = true
                    }
                    
                    self.present(vc, animated: true, completion: nil)
                    
                }
                
            }
            .disposed(by: disposeBag)
        
        
        // 애플버튼 tap
        input.appleTap
            .subscribe(with: self) { owner, _ in
                let vc = WorkSpaceInitialViewController()
                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        //로그인 성공 시
        output.isLoggedIn
            .subscribe(with: self) { owner, value in
                
                print(value)
                
                if value {
                    
                    let vc = WorkSpaceInitialViewController()
                    self.view.window?.rootViewController = vc
                    
                } else {
                    
                    self.setToastAlert(
                        message: ToastMessage
                            .SignupButton
                            .undefinedError
                            .rawValue
                    )
                    
                    print("--- 🚨로그인 실패! 화면전환X")
                    
                }
                
            }
            .disposed(by: self.disposeBag)
    }
    
    
    
}

