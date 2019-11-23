//
//  ApplicationController.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-11.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class ApplicationController: NSObject {

    var window: UIWindow?
    var hostingController: UIViewController?
    let loginViewModel: LoginViewModel
    var tokenCancellable: Cancellable?
    
    
    init(window: UIWindow) {
        self.loginViewModel = LoginViewModel()
        self.window = window
        super.init()
        setupHostingViewController()
    }
}

private extension ApplicationController {
    func setupHostingViewController() {
        hostingController = UIHostingController(rootView: ApplicationView().environmentObject(loginViewModel))
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
    }
}
