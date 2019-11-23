//
//  GithubApiProvider.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-08.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation
import Combine

final class GithubApiProvider: GitApiProviderType {
    
    struct Configuration: Codable {
        var endpoint: String
        var clientId: String
        var clientSecret: String
        
        private enum CodingKeys: String, CodingKey {
            case endpoint
            case clientId
            case clientSecret
        }
        
        var serverUrl: String {
            return "\(endpoint)/?client_id=\(clientId)&client_secret=\(clientSecret)"
        }
        
        func url(for command: GitApiCommand) -> String? {
            switch command {
            case .getUser(let user):
                guard let user = user else { return "\(endpoint)/user?client_id=\(clientId)&client_secret=\(clientSecret)" }
                return "\(endpoint)/user/\(user)?client_id=\(clientId)&client_secret=\(clientSecret)"
           
            case .getOrganizations(let user):
                guard let user = user else { return "\(endpoint)/user/orgs?client_id=\(clientId)&client_secret=\(clientSecret)" }
                return "\(endpoint)/users/\(user)/orgs?client_id=\(clientId)&client_secret=\(clientSecret)"
                
            case .getRepos(let user, let page):
                guard let user = user else { return "\(endpoint)/user/repos?page=\(page)&client_id=\(clientId)&client_secret=\(clientSecret)"}
                return "\(endpoint)/user/\(user)/repos?page=\(page)&client_id=\(clientId)&client_secret=\(clientSecret)"
            
            case .getBranches(let repo, let branche):
                guard let branche = branche else { return "\(endpoint)/repos/\(repo)/branches?client_id=\(clientId)&client_secret=\(clientSecret)" }
                return "\(endpoint)/repos/\(repo)/branches/\(branche)?client_id=\(clientId)&client_secret=\(clientSecret)"
                
            case .getCollaborator(let repo):
                return "\(endpoint)/repos/\(repo)/collaborators?client_id=\(clientId)&client_secret=\(clientSecret)"
                
            case .getCommits(let repo):
                return "\(endpoint)/repos/\(repo)/commits?client_id=\(clientId)&client_secret=\(clientSecret)"
            case .getContent(let repo, let path):
                return "\(endpoint)/repos/\(repo)/contents/\(path)?client_id=\(clientId)&client_secret=\(clientSecret)"
            case .getReadme(let repo):
                return "\(endpoint)/repos/\(repo)/readme?client_id=\(clientId)&client_secret=\(clientSecret)"
            }
        }
    }
    
    static var shared = GithubApiProvider()
    
    private init() {}
    
    var configuration: Configuration? = {
        parseConfiguration()
    }()
    
    func login(token: String?) -> PassthroughSubject<Data, Error> {
        return run(.getUser(login: nil), token: token)
    }
    
    func run(_ command: GitApiCommand, token: String?) -> PassthroughSubject<Data, Error> {
        let commandSubject = PassthroughSubject<Data, Error>()
        
        guard
            let configuration = configuration,
            let url = configuration.url(for: command)
        else {
            defer {
                commandSubject.send(completion: .failure(GitApiError.missingConfiguration))
            }
            return commandSubject
        }
        
        guard let token = token else {
            defer {
                commandSubject.send(completion: .failure(GitApiError.missingToken))
            }
            return commandSubject
        }
        
        let headers = ["Authorization": "Basic \(token)"]
        
        ApiProvider.current.request(url, command: .get, parameters: nil, headers: headers) {
            guard let data = $0.data else {
                commandSubject.send(completion: .failure(GitApiError.missingData))
                return
            }
            if let error = $0.error {
                commandSubject.send(completion: .failure(error))
                return
            }
            
            if let response = $0.response, response.statusCode > 301 {
                let message = String(data: data, encoding: .utf8)
                commandSubject.send(completion: .failure(GitApiError.invalidStatusCode(code: response.statusCode, message: message)))
                return
            }
            
            commandSubject.send(data)
        }
        
        return commandSubject
    }
}

private extension GithubApiProvider {
    
    static func parseConfiguration() -> Configuration? {
        guard let url = Bundle.main.url(forResource: "githubApiConfiguration", withExtension: "plist") else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            let configuration = try PropertyListDecoder().decode(Configuration.self, from: data)
            return configuration
        } catch {
            NSLog("unable to parse plist file")

            return nil
        }
    }
}
