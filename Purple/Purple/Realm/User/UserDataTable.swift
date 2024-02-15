//
//  UserDataTable.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/8/24.
//

import Foundation
import RealmSwift

final class UserDataTable: Object {
    
    @Persisted(primaryKey: true) var user_id: Int
    
    @Persisted var userName: String
    @Persisted var userEmail: String
    @Persisted var userImage: String?
    
    convenience init(user_id: Int, userName: String, userEmail: String, userImage: String?) {
        
        self.init()
        
        self.user_id = user_id
        self.userName = userName
        self.userEmail = userEmail
        self.userImage = userImage
        
        
    }
    
}
