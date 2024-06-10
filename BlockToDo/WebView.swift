//
//  WebView.swift
//  BlockToDo
//
//  Created by 吉江恵 on 2024/06/06.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let loardUrl: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: loardUrl)
        uiView.load(request)
    }
}

struct Web: View {
    
    var url = ""
    var title = ""
    
    @Environment(\.dismiss) var dismiss
    @State private var feedback:Bool = false
    
    var body: some View {
        NavigationStack {
            WebView(loardUrl: URL(string: url)!)
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarBackButtonHidden()
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar() {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                            feedback.toggle()
                        }) {
                            ZStack {
                                
                                Image(systemName: "chevron.backward")
                                    .symbolRenderingMode(.monochrome)
                                    .symbolVariant(.none)
                                    .fontWeight(.bold)
                            }
                        }
                        .sensoryFeedback(.impact(weight: .heavy), trigger: feedback)
                    }
                }
        }
    }
}
