//
//  ContentView.swift
//  DropboxClient
//
//  Created by Oleh Kiurchev on 19.05.2023.
//

import SwiftUI
import SwiftyDropbox

struct ContentView: View {
    var body: some View {
        Spacer()
        VStack {
            Button("Log In") {
                authButtonTapped()
            }
        }
        Spacer()
    }
}

func authButtonTapped() {
    let scopeRequest = ScopeRequest(scopeType: .user, scopes: ["account_info.read"], includeGrantedScopes: false)
        DropboxClientsManager.authorizeFromControllerV2(
            UIApplication.shared,
            controller: nil,
            loadingStatusDelegate: nil,
            openURL: { (url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil) },
            scopeRequest: scopeRequest
        )
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
