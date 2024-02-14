//
//  Wrokspace.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import Foundation

struct createWorkSpaceInput: Encodable {
    let name: String
    let description: String?
    let image: Data
}
