//
//  ChannelDataTable.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/8/24.
//

import Foundation
import RealmSwift

class ChannelDataTable: Object {
    
    //각 채널 정보
    
    @Persisted(primaryKey: true) var channelId: Int
    
    @Persisted var workspaceId: Int
    @Persisted var channelName: String
    
    convenience init(channelID: Int, workspaceID: Int, channelName: String) {
        
        self.init()
        
        self.channelId = channelID
        self.workspaceId = workspaceID
        self.channelName = channelName
        
    }
    
}
