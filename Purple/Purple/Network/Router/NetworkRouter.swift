//
//  UserRouter.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation
import Alamofire

enum NetworkRouter: URLRequestConvertible {
    
    //==== User
    case join (model: SignupInput) // 회원가입
    case emailValidation (model: EmailValidation) //이메일중복확인
    case emailLogin (model: EmailLogin) // 로그인
    case kakaoLogin (model: KakaoLogin)//카카오로그인
    case appleLogin //애플로그인
    case logout //로그아웃
    
    //==== Workspace
    case createWorkSpace (model: createWorkSpaceInput)
    
    
    //MARK: - Base URL
    
    private var baseURL: URL {
        return URL(string: BaseServer.base)!
    }
    
    //MARK: - Base URL 뒤에 붙는 path
    
    private var path: String {
        switch self {
            
            //====User
        case .join: return "/v1/users/join"
        case .emailValidation: return "/v1/users/validation/email"
        case .emailLogin: return "/v2/users/login"
        case .kakaoLogin: return "/v1/users/login/kakao"
        case .appleLogin: return "/v1/users/login/apple"
        case .logout: return "/v1/users/logout"
            
            //====WorkSpace
        case .createWorkSpace: return "/v1/workspaces"
        }
    }
    
    //MARK: - API 요청 헤더
    private var header: HTTPHeaders {
        
        switch self {
        case
            //====user
                .join,
                .emailValidation,
                .emailLogin,
                .kakaoLogin,
                .appleLogin:
            
            return [
                "Content-Type" : "application/json",
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
            
        case
                .logout:
            return [
                "Authorization" : "",
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
            
            //====workspace
        case .createWorkSpace:
            return [
                "Content-Type" : "multipart/form-data",
                "Authorization": KeychainStorage.shared.userToken!,
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
        }
        
    }
    
    //MARK: - API 요청 방식 (method)
    
    private var method: HTTPMethod {
        switch self {
            
            //====user
        case .join,
                .emailValidation,
                .emailLogin,
                .kakaoLogin,
                .appleLogin:
            
            return .post
            
        case .logout:
            return .get
            
            //====workspace
        case .createWorkSpace:
            return .post
        }
        
    }
    
    //MARK: - 서버에 보낼 데이터
    private var parameters: Parameters? {
        
        switch self {
            
            //====user
        case .appleLogin,
                .logout :
            return nil
            
        case .emailLogin(let model):
            return [
                "email": model.email,
                "password": model.password,
                "deviceToken": model.deviceToken
            ]
            
        case .join(let model):
            return [
                "email": model.email,
                "password": model.password,
                "nickname": model.nickname,
                "phone": model.phone,
                "deviceToken": model.deviceToken
            ]
            
        case .emailValidation(let model):
            return ["email": model.email]
            
        case .kakaoLogin(let model):
            return [
                "oauthToken": model.oauthToken,
                "deviceToken": model.deviceToken
            ]
            
            //====workspace
        case .createWorkSpace(let model):
            
            return [
                "name": model.name,
                "description": model.description,
                "image": model.image
            ]
        }
        
    }
    
    //MARK: - multipartDataForm
    
    var multipartFormData: MultipartFormData {
        
        let multipartFormData = MultipartFormData()
        
        if self.header["Content-Type"] == "multipart/form-data" {
            return makeMultiPartFormData()
        }
        
        return multipartFormData
        
    }
    
    
    
    //MARK: - request 구성하여 리턴
    
    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.headers = header
        request.method = method
        
        
        if method == .post && self.header["Content-Type"] != "multipart/form-data"  {
            
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            
            request.httpBody = jsonData
            
            return request
            
        }
        
        return try URLEncoding.default.encode(request, with: parameters)
        
    }
    
    
    
    //MARK: - multipartDataForm 보조

    
    private func makeMultiPartFormData() -> MultipartFormData {
        
        let multipart = MultipartFormData()
        
        for (key, value) in self.parameters! {
            
            if let imageData = value as? Data {
                multipart.append(
                    imageData,
                    withName: key,
                    fileName: "image.jpeg",
                    mimeType: "image/jpeg"
                )
            }
            
            else {
                multipart.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
        }
        
        return multipart
        
    }
    
    
    
}
