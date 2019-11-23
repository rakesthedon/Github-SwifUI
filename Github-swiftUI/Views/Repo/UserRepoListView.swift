//
//  AccountView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI
import Combine

struct UserRepoListView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        RepoListView(viewModel: RepoListViewModel(userViewModel: userViewModel))
    }
}

#if DEBUG
struct UserRepoListView_Previews: PreviewProvider {
    static var previews: some View {
        let user = PreviewConstants.user
        return UserRepoListView().environmentObject(UserViewModel(user: user, token: "aToken"))
    }
}
#endif
