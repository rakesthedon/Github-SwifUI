//
//  ApiProvider.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-08.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

enum Command: String {
        case get
        case post
}

protocol ApiProviderType: AnyObject {
    
    func request(_ url: String, command: Command, parameters: [String: Any]?, headers: [String: String]?, completion: @escaping (ApiResponse) -> ())
    
    func auth(serverURL: String, token: String, completion: @escaping (ApiResponse) -> ())
}

struct ApiResponse {
    
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
    
    init(response: HTTPURLResponse? = nil, data: Data? = nil, error: Error? = nil) {
        self.response = response
        self.data = data
        self.error = error
    }
}

final class ApiResponseParser {
    
    enum ParserError: Error {
        case missingData
    }
    
    static func parse<T: Codable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
