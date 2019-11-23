//
//  RepoListItemView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI

struct RepoListItemView: View {
    
    var repoItemViewModel: RepoItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            buildRepoView
        })
    }
    
    var buildRepoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 4) {
                Image(repoItemViewModel.isPrivate ? "lock" : repoItemViewModel.isFork ? "fork" : "git-repo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16, alignment: .center)
                    .foregroundColor(.secondary)
                
                Text(repoItemViewModel.fullName)
            }
            
            HStack(alignment: .center, spacing: 8) {
                if self.repoItemViewModel.language != nil {
                    RepoLanguageView(repoItemViewModel: repoItemViewModel)
                }
            }
        }
    }
}

struct RepoLanguageView: View {
    
    var repoItemViewModel: RepoItemViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            TagView(text: repoItemViewModel.language ?? "", tagColor: repoItemViewModel.languageColor)
                .font(.caption)
        }
    }
}
