//
//  CommitListLoader.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-29.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import UIKit
import Combine

final class CommitListLoader: NSObject {
    
    let userViewModel: UserViewModel
    let repo: Repo
    
    init(repo: Repo, userViewModel: UserViewModel) {
        self.repo = repo
        self.userViewModel = userViewModel
    }
    
    func load() -> PassthroughSubject<[CommitViewModel], Error> {
        
        let subject = PassthroughSubject<[CommitViewModel], Error>()
        
        let commitLoader: PassthroughSubject<[Commit], Error> = GitObjectLoader.load(command: .getCommits(repo: repo.fullName), token: userViewModel.token)
        
        _ = commitLoader.subscribe(on: RunLoop.main)
            .map { commits -> [CommitViewModel] in
                return commits.map({ CommitViewModel(commit: $0) })
        }.sink(receiveCompletion: {
            print($0)
        }, receiveValue: {
            subject.send($0)
        })

        return subject
    }
}
