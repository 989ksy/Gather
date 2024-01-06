//
//  ErrorResponse.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let errorCode: String
}

struct KakaoLoginResponse: Decodable {
    
    let userID: Int
    let email, nickname: String
    let profileImage, phone: String
    let vendor, createdAt: String
    let token: Token
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage, phone, vendor, createdAt, token
    }
    
}

// MARK: - Token
struct Token: Codable {
    let accessToken, refreshToken: String
}

