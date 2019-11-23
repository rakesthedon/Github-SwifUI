//
//  Language.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

final class LanguageColorList {
    
    var colors: [String: String] = [:]
    
    static var `default`: LanguageColorList = .init()
    
    private init() {
        guard let url = Bundle.main.url(forResource: "colors", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            colors = try JSONDecoder().decode([String: String].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
