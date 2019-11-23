//
//  SceneDelegate.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-08.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var applicationController: ApplicationController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else  { return }
        let window = UIWindow(windowScene: windowScene)
        let applicationController = ApplicationController(window: window)
        self.applicationController = applicationController
        self.window = window
    }
}

