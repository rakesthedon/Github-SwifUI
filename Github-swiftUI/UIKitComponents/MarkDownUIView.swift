//
//  MarkDownView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-31.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI

struct MarkDownUIView: UIViewRepresentable {
    
    var markdownView: UITextView
    let markDown: String?
    
    init(_ markDown: String?) {
        self.markDown = markDown
        markdownView = UITextView()
		markdownView.text = markDown
    }
    
    func makeUIView(context: UIViewRepresentableContext<MarkDownUIView>) -> UITextView {
        
        return markdownView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MarkDownUIView>) {
    }
}

struct MarkDownView_Previews: PreviewProvider {
    static var previews: some View {
        MarkDownUIView("""
    # Hello
    ## World
""")
    }
}
