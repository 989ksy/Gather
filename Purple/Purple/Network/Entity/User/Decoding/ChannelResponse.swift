//
//  ChannelResponse.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/28/24.
//

import Foundation

struct readMyChannelResponse: Decodable {
    
    let workspaceID: Int
    let channelID: Int
    let name: String
    let description: String
    let ownerID: Int
    let privateNm: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case workspaceID = "workspace_id"
        case channelID = "channel_id"
        case ownerID = "owner_id"
        case name, description, createdAt
        case privateNm = "private"
    }
    
}
