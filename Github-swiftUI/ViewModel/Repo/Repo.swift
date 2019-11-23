//
//  Repo.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

struct Repo: Codable, Identifiable {
    
    let id: Int
    let name: String
    let isPrivate: Bool
    let fullName: String
    let language: String?
    let fork: Bool
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case isPrivate = "private"
        case fullName = "full_name"
        case language
        case fork
        case description
    }
    
    func languageColor() -> String? {
        guard let language = language else { return nil }
        return LanguageColorList.default.colors[language]
    }
}

let sampleRepo = Repo(id: 1, name: "Text", isPrivate: false, fullName: "Full/Text",language: "Swift", fork: true, description: "Hello")
let samplePrivateRepo = Repo(id: 1, name: "Text", isPrivate: true, fullName: "Full/Text",language: "Swift", fork: false, description: nil)
