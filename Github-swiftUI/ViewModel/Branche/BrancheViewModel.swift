//
//  BrancheViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

final class BrancheViewModel: Identifiable {
    
    let branche: Branche
    
    var id: String {
        return branche.id
    }
    
    var name: String {
        return branche.name
    }
    
    var lastSha: String? {
        return branche.commit?.sha
    }
    
    init(branche: Branche) {
        self.branche = branche
    }
}
