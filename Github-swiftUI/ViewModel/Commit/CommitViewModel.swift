//
//  CommitViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-28.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import UIKit

final class CommitViewModel: NSObject, Identifiable {

    var id: String {
        return commit.sha
    }
    
    private let commit: Commit
    
    var message: String? {
        return commit.commitInfo?.message
    }
    
    init(commit: Commit) {
        self.commit = commit
    }
}
