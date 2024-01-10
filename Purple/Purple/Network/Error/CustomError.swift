//
//  CustomError.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

//import Foundation

enum CustomError: String, Error {
    
    case unauthorized = "400"
    case invalidServer = "500"
    case decodingError = "1"
    
    case e01 = "E01"
    case e02 = "E02"
    case e03 = "E03"
    case e04 = "E04"
    case e06 = "E06"
    case e11 = "E11"
    case e12 = "E12"
    case e97 = "E97"
    case e05 = "E05"
    case e98 = "E98"
    case e99 = "E99"
    
    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "400; 잘못된 요청"
        case .invalidServer:
            return "500; 서버 문제"
        case .decodingError:
            return "디코딩 오류"
        case .e01:
            return "SLP의 모든 요청 Header에는 SesacKey를 넣어주어야 합니다"
        case .e02:
            return "토큰 인증 실패"
        case .e03:
            return "계정 정보 조회에 실패: 알 수 없는 계정: 로그인실패"
        case .e04:
            return "유효한 토큰"
        case .e06:
            return "리프레시 토큰 만료: 다시 로그인해주세요."
        case .e11:
            return "잘못된 요청"
        case .e12:
            return "중복 데이터"
        case .e97:
            return "정상 라우터가 아닌 경우"
        case .e05:
            return "액세스토큰 만료"
        case .e98:
            return "서버 과호출"
        case .e99:
            return "내부 서버 오류"
        }
        
    }
}
