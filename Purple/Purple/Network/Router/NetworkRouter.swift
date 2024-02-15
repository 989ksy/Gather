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
    case emailValidation (model: EmailValidationInput) //이메일중복확인
    case emailLogin (model: EmailLoginInput) // 로그인
    case kakaoLogin (model: KakaoLoginInput)//카카오로그인
    case appleLogin //애플로그인
    case logout //로그아웃
    case readMyProfile //내 프로필 정보 조회
    
    //==== Workspace
    case createWorkSpace (model: createWorkSpaceInput) //워크스페이스 생성
    case readAllMyWorkSpace //내가 속한 워크스페이스 조회
    case readOneWorkSpace (workspaceID: Int) // 내가 속한 워크스페이스 1개 조회
    
    //==== Channel
    case createChannels (workspaceID: Int, model: createChannelInput)// 채널생성
    case readMyChannels (workspaceID: Int) //내가 속한 모든 채널 조회
    case readAllChannels (workspaceID: Int) //모든 채널 조회
    case createChannelChatting (channelNm: String, workspaceID: Int, model: createChannelChatInput)// 채널 채팅 생성
    case readChannelCahtting (channelNm: String, workspaceID: Int, cursorDate: String) //채널 채팅 조회
    
    
    //MARK: - Base URL
    
    private var baseURL: URL {
        return URL(string: BaseServer.base)!
    }
    
    //MARK: - Base URL 뒤에 붙는 path
    
    private var path: String {
        switch self {
            
            //==== User
        case .join: return "/v1/users/join"
        case .emailValidation: return "/v1/users/validation/email"
        case .emailLogin: return "/v2/users/login"
        case .kakaoLogin: return "/v1/users/login/kakao"
        case .appleLogin: return "/v1/users/login/apple"
        case .logout: return "/v1/users/logout"
        case .readMyProfile: return "/v1/users/my"
            
            //==== WorkSpace
        case .createWorkSpace: return "/v1/workspaces"
        case .readAllMyWorkSpace: return "/v1/workspaces"
        case .readOneWorkSpace (let workspaceID): return "/v1/workspaces/\(workspaceID)"
            
            //==== Channel
        case .createChannels(let workspaceID, _):
            return "/v1/workspaces/\(workspaceID)/channels"
        case .readMyChannels(let workspaceID):
            return "/v1/workspaces/\(workspaceID)/channels/my"
        case .readAllChannels(let workspaceID):
            return "/v1/workspaces/\(workspaceID)/channels"
        case .createChannelChatting(let channelNm, let workspaceID, _):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelNm)/chats"
        case .readChannelCahtting(let channelNm, let workspaceID, _):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelNm)/chats"
        }
    }
    
    //MARK: - API 요청 헤더
    private var header: HTTPHeaders {
        
        switch self {
            //==== user
        case .join,
                .emailValidation,
                .emailLogin,
                .kakaoLogin,
                .appleLogin:
            
            return [
                "Content-Type" : "application/json",
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
            
        case .logout:
            return [
                "Authorization" : "",
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
            
        case .readMyProfile:
            return [
                "Authorization": KeychainStorage.shared.userToken!,
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
            
            //==== workspace
        case .createWorkSpace:
            return [
                "Content-Type" : "multipart/form-data",
                "Authorization": KeychainStorage.shared.userToken!,
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
        case .readAllMyWorkSpace,
                .readOneWorkSpace
            :
            return [
                "Authorization": KeychainStorage.shared.userToken!,
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
            
            //==== Channel
        case .createChannels,
                .readMyChannels,
                .readAllChannels,
                .readChannelCahtting:
            return [
                "Content-Type" : "application/json",
                "Authorization": KeychainStorage.shared.userToken!,
                "SesacKey" : "\(APIKey.sesacKey)"
            ]
        
        case .createChannelChatting:
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
            
            // ====user
        case .join,
                .emailValidation,
                .emailLogin,
                .kakaoLogin,
                .appleLogin:
            
            return .post
            
        case .logout,
                .readMyProfile:
            return .get
            
            // ====workspace
        case .createWorkSpace:
            return .post
            
        case .readAllMyWorkSpace,
                .readOneWorkSpace:
            return .get
            
            
            //==== Channel
        case .readMyChannels,
                .readAllChannels,
                .readChannelCahtting
            :
            return .get
            
        case .createChannels,
                .createChannelChatting:
            return .post
        }
        
    }
    
    //MARK: - 서버에 보낼 데이터
    private var parameters: Parameters? {
        
        switch self {
            
        //==========user
        case .appleLogin,
                .logout,
                .readMyProfile:
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
            
        //========== workspace
        case .createWorkSpace(let model):
            return [
                "name": model.name,
                "description": model.description,
                "image": model.image
            ]
            
        case .readAllMyWorkSpace:
            return nil
            
        case .readOneWorkSpace(let workspaceID):
            return ["id": workspaceID]
        
        //========= Channel
        case .readMyChannels(let workspaceID):
            return ["id": workspaceID]
            
        case .createChannels(_, let model):
            return [
                    "name": model.name,
                    "description": model.description
            ]
        case .readAllChannels(let workspaceID):
            return ["id": workspaceID]
            
        case .createChannelChatting(_, _, model: let model):
            return [
                "content": model.content,
                "files": model.files
            ]
            
//        case .readChannelCahtting(let channelNm, let workspaceID, let cursorDate):
//            return [
//                "id": workspaceID,
//                "channel name": channelNm
//            ]
            
        default: return [:]
            
        }
        
    }
    
    //MARK: - 쿼리
    private var query: [String: String] {
        
        switch self {
        case .readChannelCahtting(_, _, let cursorDate):
            return [
                "cursor_date": cursorDate
            ]
            
        default:
            return [:]
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
        
        if method == .get {
            
            if let urlString = request.url?.absoluteString {
                
                var components = URLComponents(string: urlString)
                components?.queryItems = []
                
                for (key, value) in query {
                    components?.queryItems?.append(URLQueryItem(name: key, value: value))
                }
                
                if let newURL = components?.url {
                    var newURLRequest = URLRequest(url: newURL)
                    newURLRequest.headers = header
                    newURLRequest.method = method
                    
                    return newURLRequest
                }
            }
            
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
