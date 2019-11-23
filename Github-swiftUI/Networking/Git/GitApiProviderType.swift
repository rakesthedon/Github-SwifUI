//
//  AuthenticationProvider.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-08.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation
import Combine

enum GitApiCommand {
    case getUser(login: String?)
    case getOrganizations(login: String?)
    case getRepos(login: String?, page: Int)
    case getBranches(repo: String, branche: String?)
    case getCollaborator(repo: String)
    case getCommits(repo: String)
    case getReadme(repo: String)
    case getContent(repo: String, path: String)
}

enum GitApiError: Error {
    case invalidStatusCode(code: Int, message: String?)
    case missingConfiguration
    case missingData
    case missingToken
}

protocol GitApiProviderType: AnyObject {
    func login(token: String?) -> PassthroughSubject<Data, Error>
    func run(_ command: GitApiCommand, token: String?) -> PassthroughSubject<Data, Error>
}
