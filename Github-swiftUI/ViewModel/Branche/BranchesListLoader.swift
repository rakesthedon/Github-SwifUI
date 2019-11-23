//
//  BranchesListViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation
import Combine

final class BranchesListLoader: ObservableObject {
    
    enum BrancheError : Error {
        case invalidToken
    }
    
    let repo: Repo
    
    let userViewModel: UserViewModel
    
    init(repo: Repo, userViewModel: UserViewModel) {
        self.repo = repo
        self.userViewModel = userViewModel
    }

    func load() -> PassthroughSubject<[Branche], Error> {
        GitObjectLoader.load(command: .getBranches(repo: repo.fullName, branche: nil), token: userViewModel.token)
    }
}
