//
//  ApiProvider.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-09-02.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import Foundation

final class ApiProvider {
    static var current: ApiProviderType = AlamofireApiProvider.shared
}
