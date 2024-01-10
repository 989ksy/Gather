//
//  CommonError.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import Foundation

enum CustomCommonError: Int, Error, LocalizedError {
    
    case unauthorized = 400
    case invalidServer = 500
    case decodingError = 1
    
    
}
