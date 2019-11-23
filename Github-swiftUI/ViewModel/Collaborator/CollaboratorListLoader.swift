//
//  CollaboratorViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-27.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation
import Combine

final class CollaboratorListLoader: ObservableObject {

    let repo: Repo

    let userViewModel: UserViewModel
    
    init(repo: Repo, userViewModel: UserViewModel) {
        self.repo = repo
        self.userViewModel = userViewModel
    }
    
    func load() -> PassthroughSubject<[Collaborator], Error> {
        GitObjectLoader.load(command: .getCollaborator(repo: repo.fullName), token: userViewModel.token)
    }
}
