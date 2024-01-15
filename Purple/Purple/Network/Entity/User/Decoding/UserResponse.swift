//
//  ErrorResponse.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation

struct EmailLoginResponse: Decodable {
    
    let userID: Int
    let email, nickname: String
    let profileImage, phone, vendor: String?
    let createdAt: String
    let token: Token

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage, phone, vendor, createdAt, token
    }
}

struct SignupResponse: Decodable {
    
    let userID: Int
    let email, nickname: String
    let profileImage, phone, vendor: String?
    let createdAt: String
    let token: Token
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage, phone, vendor, createdAt, token
    }
}

struct KakaoLoginResponse: Decodable {
    
    let userID: Int
    let email, nickname: String
    let profileImage: String?
    let vendor: String?
    let phone: String?
    let createdAt: String
    let token: Token
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage, phone, vendor, createdAt, token
    }
    
}

// MARK: - Token
struct Token: Decodable {
    let accessToken, refreshToken: String
}

