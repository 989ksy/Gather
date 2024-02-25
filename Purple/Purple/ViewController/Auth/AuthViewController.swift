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

import AuthenticationServices

import RxSwift
import RxCocoa

import Toast

final class AuthViewController: BaseViewController {
    
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
                    self.transitionLargeSheetVC(EmailLoginViewController())
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
                
                let appleIDProvider = ASAuthorizationAppleIDProvider()
                let request = appleIDProvider.createRequest() //애플로 로그인 할거야
                request.requestedScopes = [.email, .fullName] //스코프가 빠지면 관련 정보 없어짐.
                
                let controller = ASAuthorizationController(authorizationRequests: [request])
                controller.delegate = self
                controller.presentationContextProvider = self
                controller.performRequests()
                
                
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

extension AuthViewController: ASAuthorizationControllerDelegate {
    
    //애플로 로그인 실패한 경우
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("--- 🚨애플 로그인 실패! 화면전환X")
        
    }
    
    //애플로 로그인 성공한 경우 -> 메인 페이지로 이동 등..
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        let vc = WorkSpaceInitialViewController()
        self.present(vc, animated: true)
        
    }
    
}

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!

    }
}
