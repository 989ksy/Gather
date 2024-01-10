//
//  UserService.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation
import RxSwift
import Alamofire


final class UserService {
    
    static let shared = UserService()
    
    private init() {}
    
    //MARK: - 카카오 로그인
    
    
//    func kakaoLoginRequest(
//        idToken: String,
//        nick: String,
//        deviceToken: String) -> Single<Result<KakaoLoginResponse, CustomError>> {
//        
//        let data = KakaoLogin(
//            idToken: idToken,
//            nickname: nick,
//            deviceToken: deviceToken
//        )
//        
//        return Single.create { single -> Disposable in
//            
//            Network.shared.userRequestConvertible(
//                type: KakaoLoginResponse.self,
//                api: .kakaoLogin(model: data)
//            ) { response in
//                
//                switch response {
//                case .success(let success):
//                    print("== ✅ 카카오로그인 서버 성공")
//                    single(.success(.success(success)))
//                    
//                case .failure(let failure):
//                    single(.success(.failure(failure)))
//                }
//            }
//            return Disposables.create()
//        }
//        
//    }
    
    
    //MARK: - 이메일 중복확인
    
    //    func emailValidationRequest(email: String, completion: @escaping (Single<Result<ErrorResponse, CommonError>>) -> Void) {
    //
    //        let data = EmailValidation(email: email)
    //
    //        Network.shared.userRequestConvertible(type: ErrorResponse.self, api: .emailValidation(model: data)) { response in
    //
    //            return Single.create { single -> Disposable in
    //                print("응답 상태 코드: \(String(describing: response.response?.statusCode))")
    //                print("응답 데이터: \(String(describing: String(data: response.data ?? Data(), encoding: .utf8)))")
    //
    //                switch response.result {
    //                case .success:
    //                    if response.response?.statusCode == 200 {
    //                        single(.success(nil))
    //                        print("== ✅ 이메일 서버 연결 성공")
    //                    } else {
    //                        print("== 🫢 200과 400, 500 그 사이 어딘가")
    //                    }
    //
    //                case .failure:
    //                    if let data = response.data, response.response?.statusCode == 400,
    //                       let serverError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
    //                        single(.success(serverError))
    //                    } else {
    //                        print("alamofire보장 에러")
    //                        single(.failure(response.error ?? AFError.responseValidationFailed(reason: .dataFileNil)))
    //                    }
    //                }
    //                return Disposables.create()
    //            }
    //        }
    //    }
    //
    
}
