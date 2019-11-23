//
//  UserViewModel.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-11.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import UIKit
import Combine

final class UserViewModel: ObservableObject, Identifiable {
    
    var id: Int {
        return user.id
    }
    
    var login: String? {
        return user.login
    }
    
    let user: User
    let token: String
    
    var organization: [User] = []
    
    init(user: User, token: String) {
        self.user = user
        self.token = token
    }
    
    func getUserAvatar() -> PassthroughSubject<UIImage, Error> {
        let publisher = PassthroughSubject<UIImage, Error>()
        
        guard let avatarUrl = user.avatarUrl else {
            defer {
                publisher.send(completion: .finished)
            }
            return publisher
        }
        
        ApiProvider.current.request(avatarUrl.absoluteString, command: .get, parameters: nil, headers: nil) { response in
            if let error = response.error {
                publisher.send(completion: .failure(error))
                return
            }
            
            guard let data = response.data, let img = UIImage(data: data) else {
                publisher.send(completion: .finished)
                return
            }
            
            publisher.send(img)
        }
        
        return publisher
    }
    
    func getUserOrganization() -> PassthroughSubject<[User], Error> {
        let publisher = PassthroughSubject<[User], Error>()
        
        _ = GitApiProvider.current.run(.getOrganizations(login: nil), token: token).subscribe(on: RunLoop.main).sink(receiveCompletion: { completion in
            publisher.send(completion: completion)
        }, receiveValue: { data in
            do {
                let users: [User] = try ApiResponseParser.parse(data: data)
                publisher.send(users)
            } catch {
                publisher.send(completion: .failure(error))
            }
        })
        
        return publisher
    }
}

extension UserViewModel: Equatable {
    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        lhs.user.id == rhs.user.id
    }
}

