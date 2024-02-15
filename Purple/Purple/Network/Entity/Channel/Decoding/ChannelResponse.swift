//
//  ChannelResponse.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/28/24.
//

import Foundation

//채널생성
//내가 속한 모든 채널 조회
struct readChannelResponse: Decodable {
    
    let workspaceID: Int
    let channelID: Int
    let name: String
    let description: String?
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

//채널채팅 생성
//
// MARK: - 채널정보
struct CreateChannelChatResponse: Codable {
    let channelID: Int
    let channelName: String
    let chatID: Int
    let content, createdAt: String
    let files: [String]?
    let user: ChannelUser

    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case channelName
        case chatID = "chat_id"
        case content, createdAt, files, user
    }
}

// MARK: - 유저 정보
struct ChannelUser: Codable {
    let userID: Int
    let email, nickname: String
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage
    }
}
