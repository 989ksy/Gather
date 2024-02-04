//
//  ErrorResponse.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/9/24.
//

import Foundation

struct ErrorResponse: Error, Decodable {
    var errorCode: String?
}

struct CustomErrorResponse: Error {
    var statusCode: Int
    var errorCode: String?
}
