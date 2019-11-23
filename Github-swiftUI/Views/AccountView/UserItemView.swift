//
//  UserItemView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-15.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI

struct UserItemView: View {
    var userViewModel: UserViewModel
    @State var avatar: UIImage? = nil
    var body: some View {
        HStack {
            buildAvatarView()
            Text(userViewModel.user.name ?? userViewModel.user.login ?? "NoName")
        }
    }
    
    func buildAvatarView() -> AnyView {
        guard let avatar = avatar else {
            _ = userViewModel.getUserAvatar().subscribe(on: RunLoop.main).sink(receiveCompletion: {
                print($0)
            }, receiveValue: { image in
                self.avatar = image
            })
            return AnyView(Text(""))
        }
        
        return AnyView(Image(uiImage: avatar)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 20))
    }
}

#if DEBUG
struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemView(userViewModel: UserViewModel(user: PreviewConstants.user, token: ""))
    }
}
#endif
