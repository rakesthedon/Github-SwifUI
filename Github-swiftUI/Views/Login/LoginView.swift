//
//  LoginView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    var userViewModel = PassthroughSubject<UserViewModel?, Never>()
    
    @State var isLogin: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack() {
                Image(systemName: "person")
                TextField("Email...", text: $viewModel.email)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 1.0))
            
            HStack() {
                Image(systemName: "lock.open")
                SecureField("Password...", text: $viewModel.password)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 1.0))
            
            loginButton
        }
        .padding()
        .onAppear {
            self.subscribe()
        }
    }
    
    func subscribe() {
        let subject = viewModel.loginPublisher
        let user = subject.subscribe(on: RunLoop.main).map({ data -> User? in
            do {
                return try ApiResponseParser.parse(data: data)
            } catch {
                return nil
            }
        })
        
        _ = user.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                NSLog(error.localizedDescription)
            case .finished:
                return
            }
        }, receiveValue: { (user) in
            guard let user = user else {
                self.userViewModel.send(nil)
                return
            }
            
            let userViewModel = UserViewModel(user: user, token: self.viewModel.token ?? "invalidtoken")
            self.isLogin = false
            self.userViewModel.send(userViewModel)
        })
    }
    
    func login() {
        isLogin.toggle()
        
        viewModel.login()
    }
}

private extension LoginView {
    
    var buttonView: some View {
        if !isLogin {
            return AnyView(Text("Connexion").foregroundColor(.white))
        } else {
            return AnyView(LoadingIndicatorView(style: .medium).tintColor(.white))
        }
    }
    
    var loginButton: some View {
        Button(action: login) {
            buttonView
                .padding()
                .background(Theme.foregroundColor)
                .cornerRadius(16)
        }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(LoginViewModel())
    }
}
#endif
