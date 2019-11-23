//
//  ContentView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-31.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI

struct ReadmeView: View {
    
    @ObservedObject var viewModel: ReadmeViewModel
    @State var showContent: Bool = false
    
    var body: some View {
        buildView(viewModel: viewModel).sheet(isPresented: $showContent, onDismiss: {
            self.showContent = false
        }) {
            MarkDownUIView(self.viewModel.contentString).navigationBarTitle(self.viewModel.name)
        }
    }
    
    func buildView(viewModel: ReadmeViewModel) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Button(action: {
                self.showSheet()
            }) {
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "doc.richtext")
                    Text(viewModel.name)
                }
            }
        }
    }
    
    func showSheet() {
        showContent = true
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReadmeView(content: PreviewConstants.readme)
//    }
//}
