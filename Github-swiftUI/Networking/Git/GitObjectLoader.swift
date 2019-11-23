//
//  GitObjectLoader.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-28.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Combine
import Foundation

final class GitObjectLoader {
    
    enum ObjectLoaderError: Error {
        case missingToken
        case unknown
    }

    static func load<T>(command: GitApiCommand, token: String?) -> PassthroughSubject<T, Error> where T: Codable {
        let subject = PassthroughSubject<T, Error>()
        
        
        guard let token = token else {
            defer {
                subject.send(completion: .failure(ObjectLoaderError.missingToken))
            }
            return subject
        }
        
        _ = GitApiProvider.current.run(command, token: token)
            .subscribe(on: RunLoop.main)
            .sink(
                receiveCompletion: {
                    subject.send(completion: $0)
            },
                receiveValue: { data in
                    do {
                        let collection: T = try ApiResponseParser.parse(data: data)
                        subject.send(collection)
                    } catch {
                        subject.send(completion: .failure(error))
                    }
            })
        
        return subject
    }
}
