//
//  RepoViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI
import Combine

final class RepoViewModel: ObservableObject, Identifiable {
    
    let repo: Repo
    var id: Int { return repo.id }
    var name: String { return repo.name }
    var fullName: String { return repo.fullName }
    var language: String? { return repo.language }
    var languageColor: Color { return Color(hex: repo.languageColor()) ?? Color.clear }
    var isPrivate: Bool { return repo.isPrivate }
    var isFork: Bool { return repo.fork }
    var description: String? { return repo.description }
    
    var branchesListLoader: BranchesListLoader
    var collaboratorListLoader: CollaboratorListLoader
    var commitLoader: CommitListLoader
    
    
    @Published var brancheViewModels: [BrancheViewModel] = []
    @Published var collaboratorViewModels: [CollaboratorViewModel] = []
    @Published var commitViewModels: [CommitViewModel] = []
    @Published var readmeViewModel:ReadmeViewModel
    
    var branchesSubscriber: Cancellable?
    var collaboratorSubscriber: Cancellable?
    var commitSubscriber: Cancellable?
    
    let userViewModel: UserViewModel
    
    var needLoading: Bool = true
    
    init(repo: Repo, userViewModel: UserViewModel) {
        self.repo = repo
        self.userViewModel = userViewModel
        self.branchesListLoader = BranchesListLoader(repo: repo, userViewModel: userViewModel)
        self.collaboratorListLoader = CollaboratorListLoader(repo: repo, userViewModel: userViewModel)
        self.commitLoader = CommitListLoader(repo: repo, userViewModel: userViewModel)
        self.readmeViewModel = ReadmeViewModel(repo: repo, token: userViewModel.token)
    }
    
    func load() {
        if needLoading {
            loadBranches()
            loadCollaborators()
            loadCommits()
            readmeViewModel.load()

            needLoading = false
        }
    }
    
    func clear() {
        brancheViewModels.removeAll()
        collaboratorViewModels.removeAll()
        commitViewModels.removeAll()
        
        branchesSubscriber?.cancel()
        collaboratorSubscriber?.cancel()
        commitSubscriber?.cancel()
    }
}

private extension RepoViewModel {
    
    func loadBranches() {
        branchesSubscriber?.cancel()
        branchesSubscriber = branchesListLoader.load()
            .subscribe(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .debounce(for: .seconds(1.5), scheduler: RunLoop.main)
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] in
                self?.brancheViewModels.append(contentsOf: $0.map { BrancheViewModel.init(branche: $0) })
            })
    }
    
    func loadCollaborators() {
        collaboratorSubscriber?.cancel()
        collaboratorSubscriber = collaboratorListLoader.load()
            .receive(on: RunLoop.main)
            .subscribe(on: RunLoop.main)
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] in
                self?.collaboratorViewModels.append(contentsOf: $0.map({ CollaboratorViewModel(collaborator: $0) }))
            })
    }
    
    func loadCommits() {
        commitSubscriber?.cancel()
        commitSubscriber = commitLoader.load()
            .receive(on: RunLoop.main)
            .subscribe(on: RunLoop.main)
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] in
                self?.commitViewModels.append(contentsOf: $0)
            })
    }
}
