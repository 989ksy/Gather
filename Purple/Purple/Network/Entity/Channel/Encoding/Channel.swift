//
//  Channel.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/6/24.
//

import Foundation

//채널생성
struct createChannelInput {
    
    let name: String
    let description: String
    
}

// 채널 채팅 생성
struct createChannelChatInput {
    
    let content: String
    let files: [String]?
    
}
