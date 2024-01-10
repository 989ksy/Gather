//
//  UserRouter.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    private static let key = APIKey.sesacKey
    
    case join // 회원가입
    case emailValidation (model: EmailValidation) //이메일중복확인
    case login // 로그인
    case kakaoLogin (model: KakaoLogin)//카카오로그인
    case appleLogin //애플로그인
    case logout //로그아웃
    
    
    /* Base URL */
    private var baseURL: URL {
        return URL(string: BaseServer.base)!
    }
    
    
    /* Base URL 뒤에 붙는 path */
    private var path: String {
        switch self {
        case .join:
            return "users/join"
        case .emailValidation:
            return "users/validation/email"
        case .login:
            return "users/login"
        case .kakaoLogin:
            return "users/login/kakao"
        case .appleLogin:
            return "users/login/apple"
        case .logout:
            return "users/logout"
        }
    }
    
    /* API 요청 헤더 */
    private var header: HTTPHeaders {
        
        switch self {
        case .join,
                .emailValidation,
                .login,
                .kakaoLogin,
                .appleLogin:
            
            return [
                "Content-Type" : "application/json",
                "SesacKey" : "\(APIKey.sesacKey)"

            ]
            
        case .logout:
            return [
                HTTPHeaderField.authentication.rawValue : "",
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
        }
        
    }
    
    /* API 요청 방식 (method) */
    private var method: HTTPMethod {
        switch self {
        case .join,
                .emailValidation,
                .login,
                .kakaoLogin,
                .appleLogin:
            
            return .post
            
        case .logout:
            return .get
        }
        
    }
    
    //서버에 보낼 데이터
    private var parameters: Parameters? {
        
        switch self {
        case .join,
                .login,
                
                .appleLogin,
                .logout :
            return nil
            
        case .emailValidation(let model):
            return ["email": model.email]
            
        case .kakaoLogin(let model):
            return [
                "oauthToken": model.oauthToken,
                "deviceToken": model.deviceToken
            ]
        }
        
    }
    
    

    //request 구성하여 리턴
    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.headers = header
        request.method = method
        
        
        if method == .post {
            
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            
            request.httpBody = jsonData
            
            return request
            
        }
        
        return try URLEncoding.default.encode(request, with: parameters)
            
    }
    
    
    
}
