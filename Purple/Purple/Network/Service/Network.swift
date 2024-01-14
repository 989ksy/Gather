//
//  Network.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/9/24.
//

import Foundation
import Alamofire
import RxSwift

final class Network {
    
    static let shared = Network()
    
    private init() {}
    
    typealias NetworkCompletion<T> = (Result<T, CustomErrorResponse>) -> Void
    
    //AF Request
    func request<T: Decodable>(
        type: T.Type? = nil,
        router: NetworkRouter,
        completion: @escaping NetworkCompletion<T>
    ) {
        AF.request(
            router
            //            interceptor: <#T##RequestInterceptor?#>
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            print("0-----", response)
            switch response.result {
            case .success(let data):
                print("success : \(data)")
                completion(.success(data))
            case .failure(let e):
                print("failure : \(e)")
                let statusCode = response.response?.statusCode ?? 500
                let error = self.makeCustomErrorResponse(
                    response: response,
                    statusCode: statusCode)
                completion(.failure(error))
            }
        }
    }
    
    
    func requestSingle<T: Decodable>(
        type: T.Type,
        router: NetworkRouter
    ) -> Single<Result<T, CustomErrorResponse>> {
        return Single.create { [weak self] single in
            self?.request(type: T.self, router: router) { result in
                switch result {
                case .success(let success):
                    single(.success(.success(success)))
                case .failure(let error):
                    single(.success(.failure(error)))
                }
            }
            return Disposables.create()
        }
    }
    
    func requestEmptyResponse(
        router: NetworkRouter
    ) -> Single<Void> {
        return Single.create { single in
            AF.request(router)
                .validate()
                .response { response in
                    let statusCode = response.response?.statusCode
                    print("statusCode:", statusCode!)
                    
                    if statusCode == 200 {
                        print("-----👏 EmptyResponse 네트워크 통신 성공")
                        single(.success(()))
                        
                    } else {
                        let result = response.result
                        
                        if case .failure(let failure) = result {
                            print("-----🥺 EmptyResponse 네트워크 통신 실패")
                            
                            // ErrorResponse 디코딩
                            let statusCode = response.response?.statusCode ?? 500
                            let error = self.makeCustomErrorResponse(
                                response: response,
                                statusCode: statusCode)
                            
                            // Emit an error
                            single(.failure(error))
                            
                        } else {
                            print("-----🥺 에러 디코딩 실패")
                            
                            // Emit an error if needed
                            single(.failure(NSError(domain: "ErrorErrorError", code: 1, userInfo: nil)))
                        }
                    }
                }
            return Disposables.create()
        }
    }
    

}




extension Network {
    private func makeCustomErrorResponse<T>(response: DataResponse<T, AFError>, statusCode: Int) -> CustomErrorResponse {
        
        var customErrorResponse = CustomErrorResponse(
            statusCode: 500,
            errorCode: "ServerError")
        
        guard let data = response.data else { return customErrorResponse }
        
        do {
            let serverError = try JSONDecoder().decode(ErrorResponse.self, from: data)
            print("decoding error value: \(serverError)")
            
            if let customError = CustomError(rawValue: serverError.errorCode) {
                print("---- 👿 문제:", customError.errorDescription)
            } else {
                print("Error code not found in CustomError enum")
            }
            
            customErrorResponse = CustomErrorResponse(
                statusCode: statusCode,
                errorCode: serverError.errorCode
            )
        }
        catch {
            print(error)
        }
        return customErrorResponse
    }
}
