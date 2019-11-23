//
//  BrancheView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-31.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI

struct BrancheView: View {
    
    var brancheViewModel: BrancheViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(brancheViewModel.name)
            if brancheViewModel.lastSha != nil {
                Text(brancheViewModel.lastSha!)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(10)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, idealHeight: 80, maxHeight: 80, alignment: .leading).padding()
            .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(10)
    }
}

struct BrancheView_Previews: PreviewProvider {
    static var previews: some View {
        BrancheView(brancheViewModel: BrancheViewModel(branche: Branche(name: "Some Some", protected: false, commit: Commit(url: URL(string: "https://www.google.com")!, sha: "ashastring1234", author: nil, commitInfo: nil)))).colorScheme(.dark)
    }
}
