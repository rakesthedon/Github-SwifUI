//
//  RepoListView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI

struct RepoListView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var viewModel: RepoListViewModel
    @State var repos: [Repo] = []
    @State var currentPage = 1
    
    
    var body: some View {
        buildView().onAppear {
            self.getRepos()
        }
    }
    
    func getRepos() {
        let repoPublisher = GitApiProvider.current.run(.getRepos(login: nil, page: currentPage), token: userViewModel.token).subscribe(on: RunLoop.main)
        _ = repoPublisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                NSLog(error.localizedDescription)
            case .finished:
                return
            }
        }, receiveValue: { (data) in
            do {
                let repos: [Repo] = try ApiResponseParser.parse(data: data)
                self.repos.append(contentsOf: repos)
            } catch {
                print(error)
            }
        })
    }

    func buildView() -> some View {
        let list = List(repos) { repo in
            NavigationLink(destination: RepoDetailView(repoViewModel: RepoViewModel(repo: repo, userViewModel: self.userViewModel))) {
                RepoListItemView(repoItemViewModel: RepoItemViewModel(repo: repo))
                .listRowInsets(EdgeInsets())
            }
            .listStyle(GroupedListStyle())
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(16)
        }
        
        return list
    }
}
//
//#if DEBUG
//struct RepoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RepoListView()
//    }
//}
//#endif
