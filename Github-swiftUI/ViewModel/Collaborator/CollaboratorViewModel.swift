//
//  CollaboratorViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-27.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation


final class CollaboratorViewModel: Identifiable {
    
    let collaborator: Collaborator
    
    var id: Int {
        return collaborator.id
    }
    
    init(collaborator: Collaborator) {
        self.collaborator = collaborator
    }
}
