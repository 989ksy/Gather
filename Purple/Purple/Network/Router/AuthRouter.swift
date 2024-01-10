//
//  AuthRouter.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation
import Alamofire

//토큰갱신

enum AuthRouter: URLRequestConvertible {
    
    case refresh(RefreshToken: String)
    
    
    private var baseURL: URL { //String
        return URL(string: BaseServer.base)!
    }
    
    
    private var path: String { //endpoint : URL
        switch self {
        case .refresh:
            return "auth/refresh"
        }
    }
    
    var header: HTTPHeaders {
        
        return [
            "Content-Type" : "application/json",
            "Authorization" : "",
            "SesacKey" : "\(APIKey.sesacKey)",
            "RefreshToken" : ""
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    
    var parameters: [String: String] {
        
        switch self {
        case .refresh(let RefreshToken):
            return [
                "RefreshToken" : " "
            ]
        }
    }
    
    /*
     인코딩 방식
         - 파라미터로 보내야할 것이 있다면, URLEncoding.default
         - 바디에 담아서 보내야할 것이 있다면, JSONEncoding.default
     */
    
    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.headers = header
        request.method = method
        
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(parameters, into: request)
        
        return request
        
    }
    
    
}
