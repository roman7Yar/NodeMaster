//
//  WebView.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 12.06.2023.
//

import SwiftUI
import WebKit
import SafariServices

struct WebView: UIViewControllerRepresentable {
    
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<WebView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<WebView>) {
    }

}
