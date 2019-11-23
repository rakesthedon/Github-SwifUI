//
//  AlamofireApiProvider.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-08.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import UIKit
import Alamofire

final class AlamofireApiProvider: ApiProviderType {
    
    static var shared = AlamofireApiProvider()
    
    private init() {
    }
    
    func request(_ url: String, command: Command, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (ApiResponse) -> ()) {
        let request = Alamofire.request(url, method: command.alamofireHttpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        request.response(queue: DispatchQueue.global(qos: .utility)) { response in
            completion(ApiResponse(response: response.response,data: response.data, error: response.error))
        }
    }
    
    func auth(serverURL: String, token: String, completion: @escaping (ApiResponse) -> ()) {
        let headers = ["Authorization": "Basic \(token)"]
        request(serverURL, command: .get, parameters: nil, headers: headers, completion: completion)
    }
}


private extension Command {
    var alamofireHttpMethod: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}
