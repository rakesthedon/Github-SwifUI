//
//  User.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-11.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    
    let login: String?
    let email: String?
    let name: String?
    let bio: String?
    let avatarUrl: URL?
    
    var token: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case login
        case email
        case name
        case bio
        case avatarUrl = "avatar_url"
    }
}
