//
//  AccountView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-15.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI
import Combine

struct AccountView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @State var avatar: UIImage? = nil
    @State var organizations: [UserViewModel]? = nil
    @State var showLogoutAlert: Bool = false
    
    var logoutPublisher = PassthroughSubject<Void, Never>()
    
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 20) {
                buildUserAvatarView()
                Text(userViewModel.user.name ?? userViewModel.user.login ?? "")
                    .font(.title)
                
                buildOrganisationView()
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(16)
            
            Spacer()
            
            Button(action: { self.showLogoutAlert.toggle() }) {
                Text("Log out")
            }
        }.actionSheet(isPresented: $showLogoutAlert) {
            return self.showAlert()
        }
    }
}



private extension AccountView {
    
    func showAlert() -> ActionSheet {
        return ActionSheet(title: Text("Log out?"), message: nil, buttons: [ActionSheet.Button.default(
            Text("Confirm"),
            action: {
                self.logout()
        }), .cancel()])
    }
    
    func buildUserAvatarView() -> AnyView {
        guard let avatar = avatar else {
            let loadingView = LoadingIndicatorView(style: .medium).tintColor(.placeholderText)
            
            _ = self.userViewModel.getUserAvatar()
                .subscribe(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    print(String(describing: completion))
                }, receiveValue: { image in
                    self.avatar = image
                })
            
            let view = AnyView(loadingView)
            
            
            return view
        }
        
        return AnyView(
            Image(uiImage: avatar)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.secondary, lineWidth: 2))
                .shadow(radius: 10)
        )
    }
    
    func buildOrganisationView() -> AnyView {
        guard let organizations = organizations else {
            _ = self.userViewModel.getUserOrganization()
                .subscribe(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    print(String(describing: completion))
                }, receiveValue: { users in
                    self.organizations = users.map { UserViewModel(user: $0, token: "") }
                })
            return AnyView(Text("..."))
        }
        
        return AnyView(
            Group {
                ForEach(organizations) { userViewModel in
                    UserItemView(userViewModel: userViewModel)
                }
            }
        )
    }
    
    func logout() {
        logoutPublisher.send()
    }
}

#if DEBUG
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView().environmentObject(UserViewModel(user: PreviewConstants.user, token: "TOKEN"))
    }
}
#endif
