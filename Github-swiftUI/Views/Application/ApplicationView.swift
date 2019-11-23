//
//  ApplicationView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-11.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI

struct ApplicationView: View {
    
    enum ViewType {
        case login
        case account
    }
    
    var loginView = LoginView()
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State var showUserProfile: Bool = false
    @State var userViewModel: UserViewModel? = nil {
        didSet {
            if self.userViewModel != nil {
                self.currentViewType = .account
            } else {
                self.currentViewType = .login
            }
        }
    }
    
    @State var currentViewType: ViewType = .login
    @State var avatar: UIImage? = nil
    
    var body: some View {
        setupContainingView().accentColor(Theme.foregroundColor)
    }
}

private extension ApplicationView {
    
    func addSubscription() {
        _ = loginView.userViewModel.subscribe(on: RunLoop.main).sink(receiveValue: {
            self.userViewModel = $0
        })
    }
    
    var repoView: some View {
        NavigationView {
            UserRepoListView()
                .navigationBarTitle(Text("Repositories"), displayMode: .large)
                .navigationViewStyle(DoubleColumnNavigationViewStyle())
                .navigationBarItems(
                    trailing: profilButton)
        }
    }
    
    var profilButton: some View {
        Button(
            action: { self.showUserProfile.toggle() },
            label: {
                return Image(systemName: "person.crop.circle")
            })
            .padding()
    }
    
    var accountView : some View {
        let accountView = AccountView()
        _ = accountView.logoutPublisher
            .subscribe(on: RunLoop.main)
            .sink(receiveValue: {
                self.showUserProfile = false
                self.userViewModel = nil
            })
        return accountView
    }
    
    func setupContainingView() -> some View {
        addSubscription()
        
        switch currentViewType {
        case .login:
            return AnyView(loginView)
        case .account:
            guard let userViewModel = userViewModel else {
                fatalError()
            }
            
            return AnyView(
                repoView.environmentObject(userViewModel)
                    .sheet(isPresented: $showUserProfile, content: {
                        self.accountView.environmentObject(userViewModel)
                    })
            )
        }
    }
}

#if DEBUG
struct ApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationView()
    }
}
#endif
