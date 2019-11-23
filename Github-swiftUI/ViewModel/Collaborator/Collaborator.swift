//
//  Collaborator.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-27.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation
import Combine

struct Collaborator: Identifiable {
    
    let id: Int
    let login: String
    let avatarUrl: URL?
}

extension Collaborator: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
}
