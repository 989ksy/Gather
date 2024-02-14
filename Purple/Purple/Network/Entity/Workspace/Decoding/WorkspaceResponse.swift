//
//  WorkspaceResponse.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import Foundation

struct createWorkSpaceResponse: Decodable {
    
    var workspaceID: Int
    let name: String
    let description: String
    let thumbnail: String
    let ownerID: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case workspaceID = "workspace_id"
        case ownerID = "owner_id"
        case name,description, thumbnail, createdAt
    }
    
}

struct readOneWorkspaceResponse: Decodable {
    
    let workspaceID: Int
    let name, description, thumbnail: String
    let ownerID: Int
    let createdAt: String
    let channels: [Channel]?
    let workspaceMembers: [WorkspaceMember]?

    enum CodingKeys: String, CodingKey {
        case workspaceID = "workspace_id"
        case name, description, thumbnail
        case ownerID = "owner_id"
        case createdAt, channels, workspaceMembers
    }
    
}

// MARK: - Channel
struct Channel: Decodable {
    let workspaceID, channelID: Int?
    let name, description: String?
    let ownerID: Int?
    let createdAt: String?
    let channelPrivate: Int?

    enum CodingKeys: String, CodingKey {
        case workspaceID = "workspace_id"
        case channelID = "channel_id"
        case name, description
        case ownerID = "owner_id"
        case channelPrivate = "private"
        case createdAt
    }
}

// MARK: - WorkspaceMember
struct WorkspaceMember: Decodable {
    let userID: Int?
    let email, nickname: String?
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage
    }
}
