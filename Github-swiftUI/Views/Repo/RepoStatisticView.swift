//
//  RepoStatisticView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-13.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI

struct RepoStatisticView: View {
    
    @EnvironmentObject var repoViewModel: RepoViewModel
    
    let loadingIndicatorStyle: UIActivityIndicatorView.Style = .medium
    
    var body: some View {
        HStack {
            TagView(
                image: Image(systemName: "arrow.branch"),
                text: "\(repoViewModel.brancheViewModels.count)",
                expended: true)
            TagView(
                image: Image(systemName: "gobackward"),
                text: "\(repoViewModel.commitViewModels.count)",
                expended: true)
            TagView(
                image: Image(systemName:"person.2.fill"),
                text: "\(repoViewModel.collaboratorViewModels.count)",
                expended: true)
        }
    }
}
//
//#if DEBUG
//struct RepoStatisticView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            RepoStatisticView().environmentObject(RepoViewModel(repo: sampleRepo))
//        }.previewLayout(.fixed(width: 300, height: 200))
//    }
//}
//#endif

struct TagView: View {
    var image: Image? = nil
    var text: String
    var expended: Bool = false
    var tagColor: Color = Theme.foregroundColor
    
    var stack: some View {
        HStack(alignment: .center, spacing: 4, content: {
            if image != nil {
                image
            }
            Text(text)
                .scaledToFill()
        }).colorScheme(.dark)
    }
    
    var body: some View {
        if expended {
            return AnyView(stack
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding([.top, .bottom], 4)
            .background(Theme.foregroundColor)
            .cornerRadius(8))
        }
        return AnyView(stack
            .padding(.horizontal, 8)
            .padding([.top, .bottom], 4)
            .background(tagColor)
            .cornerRadius(8))
    }
}
