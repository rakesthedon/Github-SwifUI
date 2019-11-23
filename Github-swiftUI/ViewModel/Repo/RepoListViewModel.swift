//
//  RepoListViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation
import Combine

final class RepoListViewModel: ObservableObject {
    
    var didChange = PassthroughSubject<Void, Never>()
    
    @Published var repos: [Repo] = []
    
    let userViewModel: UserViewModel
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
    }
    
    func repoItemViewModel(at index: Int) -> RepoItemViewModel {
        return RepoItemViewModel(repo: repos[index])
    }
    
    func repoViewModel(at index: Int) -> RepoViewModel {
        return RepoViewModel(repo: repos[index], userViewModel: userViewModel)
    }
    
    func didReceive(repos: [Repo]) {
        self.repos.append(contentsOf: repos)
    }
    
    func getRepos() -> PassthroughSubject<[Repo], Error> {
        let publisher = PassthroughSubject<[Repo], Error>()
        
        let repoPublisher = GitApiProvider.current.run(.getRepos(login: nil, page: 1), token: userViewModel.token).subscribe(on: RunLoop.main)
        _ = repoPublisher.sink(receiveCompletion: { completion in
            publisher.send(completion: completion)
        }, receiveValue: { (data) in
            do {
                let repos: [Repo] = try ApiResponseParser.parse(data: data)
                publisher.send(repos)
            } catch {
                print(error)
            }
        })
        
        return publisher
    }
}
