//
//  GitApiProvider.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-09-03.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

final class GitApiProvider {
    static let current: GitApiProviderType = GithubApiProvider.shared
}
