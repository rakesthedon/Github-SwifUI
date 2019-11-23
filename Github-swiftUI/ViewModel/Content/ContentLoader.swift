//
//  ContentLoader.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-31.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation
import Combine

final class ContentLoader {
    
    let userViewModel: UserViewModel
    let repo: Repo
 
    init(repo: Repo, userViewModel: UserViewModel) {
        self.repo = repo
        self.userViewModel = userViewModel
    }
    
    func loadReadme() -> PassthroughSubject<Content, Error> {
        GitObjectLoader.load(command: .getReadme(repo: repo.fullName), token: userViewModel.token)
    }
}
