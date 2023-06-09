//
//  DropboxClientApp.swift
//  DropboxClient
//
//  Created by Oleh Kiurchev on 19.05.2023.
//

import SwiftUI
import SwiftyDropbox
import ComposableArchitecture

@main
struct DropboxClientApp: App {
    init() {
        DropboxClientsManager.setupWithAppKey("ky61jf1mf6pqxd7")
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: Root.State()) {
                    Root()
                }
            )
        }
    }
}
