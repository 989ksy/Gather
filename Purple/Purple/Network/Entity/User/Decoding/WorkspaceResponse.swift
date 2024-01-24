//
//  WorkspaceResponse.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import Foundation

struct createWorkSpaceResponse: Decodable {
    
    let workspaceID: Int
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
