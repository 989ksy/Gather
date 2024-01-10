//
//  ToastMessage.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/4/24.
//

import Foundation

struct ToastMessage {
    
    //[중복 확인] 버튼 클릭
    enum ValidationButton: String {
        
        //이메일 유효성 오류
        case emailValidationError = "이메일 형식이 올바르지 않습니다."

        //사용 가능한 이메일 & 이미 검증된 상태
        case availableEmail = "사용 가능한 이메일입니다."
    }
    
    //[가입하기] 버튼 클릭
    enum SignupButton: String {
        
        
        case EmailValidationFailed = "이메일 중복 확인을 진행해주세요."
        case nickError = "닉네임은 1글자 이상 30글자 이내로 부탁드려요."
        case phoneNumError = "잘못된 전화번호 형식입니다."
        case passwordError = "비밀번호는 최소 8자 이상, 하나 이상의 대소문자/숫자/특수문자를 설정해주세요."
        case passwordCheckError = "작성하신 비밀번호가 일치하지 않습니다."
        case signedMember = "이미 가입된 회원입니다. 로그인을 진행해주세요."
        case undefinedError = "에러가 발생했어요. 잠시 후 다시 시도해주세요."//기타 오류
        
    }
    
}
