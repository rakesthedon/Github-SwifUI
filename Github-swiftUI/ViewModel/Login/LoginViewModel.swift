//
//  User.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-10.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    
    enum Keys: String {
        case email
    }
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var token: String? = nil
    
    var loginPublisher = PassthroughSubject<Data, Error>()
    
    init() {
        fetchStoredLoginInfo()
    }
    
    func store(token: String?) {
        self.token = token
        do {
            // This is a new account, create a new keychain item with the account name.
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: email, accessGroup: KeychainConfiguration.accessGroup)
            
            // Save the token for the new item.
            if let token = token {
                UserDefaults.standard.set(email, forKey: Keys.email.rawValue)
                try passwordItem.savePassword(token)
            } else {
                UserDefaults.standard.removeObject(forKey: Keys.email.rawValue)
                try passwordItem.deleteItem()
            }
        }
        catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
    
    func fetchStoredLoginInfo() {
        guard let storedEmail = UserDefaults.standard.value(forKey: Keys.email.rawValue) as? String else {
            return
        }
        
        do {
            email = storedEmail
            
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: email, accessGroup: KeychainConfiguration.accessGroup)
            let storedToken = try passwordItem.readPassword()
            
            token = storedToken
            
            login(with: token)
        } catch {
            NSLog(error.localizedDescription)
            store(token: nil)
        }
    }
    
    func invalidateToken() {
        token = nil
        store(token: token)
    }
    
    func generateToken() -> String? {
        guard !email.isEmpty, !password.isEmpty else { return nil }
        let authString = "\(email):\(password)"
        guard let token = authString.data(using: .utf8)?.base64EncodedString() else {
            return nil
        }

        return token
    }
    
    func login() {
        self.token = generateToken()
        login(with: self.token)
    }
    
    func login(with token: String?) {
        let subject = GitApiProvider.current.login(token: token)
        
        _ = subject.receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] in
                    self?.loginPublisher.send(completion: $0)
            },
                receiveValue: { [weak self] in
                    self?.loginPublisher.send($0)
                    self?.store(token: self?.token)
            })
    }
}
