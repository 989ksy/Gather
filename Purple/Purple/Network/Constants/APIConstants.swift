//
//  APIConstants.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation

struct APIConstants {
    
    // MARK: - Start Endpoint
    static var baseURL: URL {
        return URL(string: BaseServer.base)!
    }

    static let token = ""
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}
