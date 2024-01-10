//
//  Keychain.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/6/24.
//

import UIKit
import SwiftKeychainWrapper

private struct KeychainKeys {
    static let userTokenKey: String = "User.Token.Key"
    static let userRefreshTokenKey: String = "User.RefeshToken.Key"
    static let userIDKey : String = "User.ID.Key"
}

final class KeychainStorage {
    
    static let shared = KeychainStorage()
    private init() {}
    
    //MARK: - token
    
    var userToken: String? {
        get {
            KeychainWrapper.standard.string(forKey: KeychainKeys.userTokenKey)
        }
        set {
            if let value = newValue {
                KeychainWrapper.standard.set(value, forKey: KeychainKeys.userTokenKey)
            } else {
                KeychainWrapper.standard.removeObject(forKey: KeychainKeys.userTokenKey)
            }
        }
    }
    
    //MARK: - RefreshToken
    
    var userRefreshToken: String? {
        get {
            KeychainWrapper.standard.string(forKey: KeychainKeys.userRefreshTokenKey)
        }
        set {
            if let value = newValue {
                KeychainWrapper.standard.set(value, forKey: KeychainKeys.userRefreshTokenKey)
            } else {
                KeychainWrapper.standard.removeObject(forKey: KeychainKeys.userRefreshTokenKey)
            }
        }
    }
    
    
    //MARK: - User Email
    
    var userEmail: String {
        get {
            if let nickname = KeychainWrapper.standard.string(forKey: KeychainKeys.userIDKey) {
                return nickname
            }
            else {
                return "이메일 없음"
            }
        }
        set {
            if !newValue.isEmpty {
                KeychainWrapper.standard.set(newValue, forKey: KeychainKeys.userIDKey)
            } else {
                KeychainWrapper.standard.removeObject(forKey: KeychainKeys.userIDKey)
            }
        }
    }
    
    
    //MARK: - User nickname
    
    var userNickname: String {
        get {
            if let nickname = KeychainWrapper.standard.string(forKey: KeychainKeys.userIDKey) {
                return nickname
            } else {
                return "닉네임 없음"
            }
        }
        set {
            if !newValue.isEmpty {
                KeychainWrapper.standard.set(newValue, forKey: KeychainKeys.userIDKey)
            } else {
                KeychainWrapper.standard.removeObject(forKey: KeychainKeys.userIDKey)
            }
        }
    }
    
    
    
    
    //MARK: - RemoveAll
    
    func removeAllKeys() {
        KeychainWrapper.standard.removeAllKeys()
    }
    
}
