//
//  AuthError.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation

enum AuthError: Error, LocalizedError {
    
    case unauthorized (errorCode: String)
    
    var statusCode: Int {
        switch self {
        case .unauthorized:
            return 400
        }
    }
    
    var errorDescription: String {
        switch self {
        case let .unauthorized(errorCode):
            if let errorDescription = ErrorCode(rawValue: errorCode)?.rawValue {
                return "\(statusCode): \(errorDescription)"
            } else {
                return "\(statusCode): Unknown error code"
            }
            
        }
    }
    
}
