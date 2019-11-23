//
//  RepoItemViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-30.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI
import Combine

final class RepoItemViewModel: ObservableObject, Identifiable {
    
    let repo: Repo
    var id: Int { return repo.id }
    var name: String { return repo.name }
    var fullName: String { return repo.fullName }
    var language: String? { return repo.language }
    var languageColor: Color { return Color(hex: repo.languageColor()) ?? Color.clear }
    var isPrivate: Bool { return repo.isPrivate }
    var isFork: Bool { return repo.fork }
    var description: String? { return repo.description }
    
    var branchesSubscriber: Cancellable?
    var collaboratorSubscriber: Cancellable?
    var commitSubscriber: Cancellable?
    
    init(repo: Repo) {
        self.repo = repo
    }
}
