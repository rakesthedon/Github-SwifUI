//
//  RepoDetailView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI

struct RepoDetailView: View {
    
   @ObservedObject var repoViewModel: RepoViewModel
    
    var body: some View {
        list
            .navigationBarTitle(Text(repoViewModel.repo.name), displayMode: .inline)
            .onAppear {
                self.repoViewModel.load()
            }
    }
}

private extension RepoDetailView {
    
    var list: some View {
        List {
            VStack(alignment: .leading, spacing: 16) {
                if repoViewModel.description != nil && repoViewModel.description?.isEmpty == false {
                    Text(repoViewModel.description ?? "")
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                }
                RepoStatisticView().environmentObject(repoViewModel)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            if !repoViewModel.readmeViewModel.contentString.isEmpty {
                ReadmeView(viewModel: repoViewModel.readmeViewModel)
            }
            
            if repoViewModel.brancheViewModels.count > 0 {
                Group {
                ForEach(repoViewModel.brancheViewModels) { brancheViewModel in
                    BrancheView(brancheViewModel: brancheViewModel)
                    }
                }
            } else {
                LoadingIndicatorView(style: .large).tintColor(.label)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
//#if DEBUG
//struct RepoView_Previews: PreviewProvider {
//    static var previews: some View {
//        RepoView(repoViewModel: RepoViewModel(repo: sampleRepo))
//    }
//}
//#endif

