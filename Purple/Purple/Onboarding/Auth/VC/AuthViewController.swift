//
//  AuthViewController.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit
import RxSwift
import RxCocoa

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class AuthViewController: BaseViewController, UISheetPresentationControllerDelegate {
    
    let mainView = AuthView()
    let viewModel = AuthViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindVM()
        
    }
    
    override func configureView() {
        view.backgroundColor = ConstantColor.bgPrimary
    }
    
    func bindVM() {
        
        let input = AuthViewModel.Input(singupTap: mainView.signUpButton.rx.tap, kakaoTap: mainView.kakaoLoginButton.rx.tap)
        
        //회원가입 버튼 tap
        input.singupTap
            .subscribe(with: self) { owner, _ in
                
                let vc = SignupViewController()
                vc.modalPresentationStyle = .pageSheet
                
                if let sheet = vc.sheetPresentationController {
                    sheet.detents = [.large()]
                    sheet.delegate = self
                    sheet.prefersGrabberVisible = true
                }
                
                self.present(vc, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        //카카오 버튼 tap
        input.kakaoTap
            .subscribe(with: self) { owner, _ in
                
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("loginWithKakaoTalk() success.")

                            let accessToken = oauthToken?.accessToken
                            let idToken = oauthToken?.idToken
                            
                        }
                    }
                }
                
                
            }
            .disposed(by: disposeBag)
    }
    
    
    
}
