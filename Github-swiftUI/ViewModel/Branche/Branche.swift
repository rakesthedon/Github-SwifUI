//
//  Branche.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

struct Branche: Codable, Identifiable {
    
    var id: String {
        return name
    }
    
    let name: String
    let protected: Bool
    let commit: Commit?
    
    enum CodingKeys: String, CodingKey {
        case name
        case protected
        case commit
    }
}
