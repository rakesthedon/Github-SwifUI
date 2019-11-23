//
//  ReadmeViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-31.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation
import Combine

final class ReadmeViewModel: ObservableObject {
    
    @Published var content: Content?
    @Published var loadingFailed = false
    
    let repo: Repo
    let token: String?

    var subscriber: Cancellable?
    
    var name: String {
        return content?.name ?? ""
    }
    var encoding: String {
        return content?.encoding ?? ""
    }
    var contentString: String {
        guard let content = content?.content else { return "" }
        guard let data = Data(base64Encoded: content, options: .ignoreUnknownCharacters) else { return content }
        
        
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    var downloadUrl: URL? {
        return content?.downloadUrl
    }
    
    init(repo: Repo, token: String?) {
        self.repo = repo
        self.token = token
    }
    
    func load() {
        subscriber?.cancel()
        let loader: PassthroughSubject<Content, Error> = GitObjectLoader.load(command: .getReadme(repo: repo.fullName), token: token)
        subscriber = loader
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] in
                switch $0 {
                case .failure:
                    self?.loadingFailed = true
                default:
                    break
                }
                }, receiveValue: { [weak self] in
                    self?.content = $0
            })
    }
}
