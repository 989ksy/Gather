//
//  AuthViewModel.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import Foundation
import RxSwift
import RxCocoa
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class AuthViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        
        let singupTap: ControlEvent<Void> //회원가입
        let kakaoTap: ControlEvent<Void> //카카오로그인
        let appleTap: ControlEvent<Void> //애플로그인
        
    }
    
    struct Output {
        
        let isLoggedIn: Observable<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        
        let isLoggedIn = PublishSubject<Bool>()
        
        let oauthToken1 = PublishSubject<String>()
        let deviceToken1 = PublishSubject<String>()
                
        input.kakaoTap
            .throttle(.seconds(1),
                      scheduler: MainScheduler.instance)
            .subscribe(with: self) { owner, _ in
                if UserApi.isKakaoTalkLoginAvailable() {
                    
                    UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                        //카카오톡 설치 안됨
                        if let error = error {
                            print("--- 🚨카카오톡 설치 X", error)
                        }
                        
                        else {
                            print("--- ✅ loginWithKakaoTalk() success.")
                            
                            //사용자 정보 가져오기 (이메일 & 닉네임 저장 및 전송)
                            UserApi.shared.me {  user, error in
                                if let error = error {
                                    print(error)
                                } else {
                                    
                                    guard let accessToken = oauthToken?.accessToken,
                                          let refereshToken = oauthToken?.refreshToken,
                                          let email = user?.kakaoAccount?.email,
                                          let nickname = user?.kakaoAccount?.profile?.nickname
                                    else {
                                        
                                        print("token/email/name is nil")
                                        
                                        return
                                    }
                                    
                                    oauthToken1.onNext(accessToken)
                                    deviceToken1.onNext(refereshToken)
                                    
                                    print("======👀 [사용자 이메일]", email)
                                    print("======👀 [사용자 닉네임]", nickname)
                                    print("======👀 [사용자 액세스토큰/oauthToken]", accessToken)
                                    print("======👀 [사용자 리프레시토큰/deviceToken]", refereshToken)
                                    
                                    //✅ 이메일/닉네임/토큰 저장하기
                                    KeychainStorage.shared.userEmail = email
                                    KeychainStorage.shared.userNickname = nickname
                                    KeychainStorage.shared.userToken = accessToken
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            .disposed(by: disposeBag)
            

        
        
        let test = Observable.combineLatest(oauthToken1, deviceToken1)
        
        test
            .flatMap { value in
                print("--------",value)
                let data = KakaoLogin(oauthToken: value.0, deviceToken: value.1)
                
                print(value.0)
                print(value.1)
                
                return Network.shared.requestSingle(
                    type: KakaoLoginResponse.self ,
                    router: .kakaoLogin(model: data)
                )
            }
            .subscribe(with: self) { owner, result in
                print("--------")
                print(result)
                switch result {
                case .success(let response):

                    isLoggedIn.onNext(true)
                    print("성공")
                    
                case .failure(let error):
                    return print("실패", error)
                }
            }
            .disposed(by: disposeBag)
            
        
        
            
        
        return Output(isLoggedIn: isLoggedIn)
    }
    
    
    
}
