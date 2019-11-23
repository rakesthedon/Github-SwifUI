//
//  LoadingIndicatorView.swift
//  Github-swiftUI
//
//  Created by Yannick Jacques on 2019-08-10.
//  Copyright © 2019 Yannick Jacques. All rights reserved.
//

import SwiftUI
import UIKit

struct LoadingIndicatorView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    private let style: UIActivityIndicatorView.Style
    private var indicatorView: UIActivityIndicatorView
    
    init(style: UIActivityIndicatorView.Style) {
        self.style = style
        self.indicatorView = UIActivityIndicatorView(style: style)
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: style)
        return indicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
    
    func tintColor(_ color: UIColor) -> LoadingIndicatorView {
        indicatorView.tintColor = color
        return self
    }
}

#if DEBUG
struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView(style: .medium)
    }
}
#endif
