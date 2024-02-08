//
//  ChatDataTable.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/8/24.
//

import Foundation
import RealmSwift

class ChatDataTable: Object {
    
    @Persisted(primaryKey: true) var chatId: Int
    
    @Persisted var userData: UserDataTable?
    @Persisted var channelData: ChannelDataTable?
    
    @Persisted var content: String //채팅내용
    @Persisted var createdAt: Date
    
    convenience init(userData: UserDataTable?, channelData: ChannelDataTable?, content: String, createdAt: Date) {
        
        self.init()
        
        self.userData = userData
        self.channelData = channelData
        self.content = content
        self.createdAt = createdAt
        
    }
    
}
