//
//  Commit.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-28.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

struct Commit {
    
    var url: URL
    var sha: String
    var author: User?
    var commitInfo: CommitInfo?
}

extension Commit: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case url
        case sha
        case author
        case commitInfo = "commit"
    }
}

extension Commit: Identifiable {
    var id: String {
        return sha
    }
}
