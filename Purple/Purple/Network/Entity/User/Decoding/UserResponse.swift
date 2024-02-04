//
//  ErrorResponse.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation

//MARK: - 이메일 로그인

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

//MARK: - 회원가입

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

//MARK: - 회원가입

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


//MARK: - 내 프로필 조회

struct readMyProfileResponse: Decodable {
    
    let userID: Int
    let email, nickname: String
    let profileImage, phone, vendor: String?
    let sesacCoin: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage, phone, vendor, sesacCoin, createdAt
    }
    
}
