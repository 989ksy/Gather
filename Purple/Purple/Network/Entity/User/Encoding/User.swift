//
//  EmailValidationInput.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation

//이메일 로그인
struct EmailLoginInput: Encodable {
    let email: String
    let password: String
    let deviceToken: String
}

//회원가입
struct SignupInput: Encodable {
    let email: String
    let password: String
    let nickname: String
    let phone: String
    let deviceToken: String
}

//이메일 중복
struct EmailValidationInput: Encodable {
    let email: String
}

//카카오 로그인
struct KakaoLoginInput: Encodable {
    let oauthToken, deviceToken: String
}
