//
//  EmailValidationInput.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation

//이메일 중복
struct EmailValidation: Encodable {
    let email: String
}

//카카오 로그인
struct KakaoLogin: Encodable {
    let oauthToken, deviceToken: String
}
