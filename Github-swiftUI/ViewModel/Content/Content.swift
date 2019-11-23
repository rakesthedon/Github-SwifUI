//
//  ReadmeModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-31.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

struct Content {
    
    let type: String
    let name: String
    let url: URL
    let downloadUrl: URL
    let content: String?
    let encoding: String?
}

extension Content: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case url
        case downloadUrl = "download_url"
        case content
        case encoding
    }
}
