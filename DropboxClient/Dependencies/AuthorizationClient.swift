//
//  AuthorizationClient.swift
//  DropboxClient
//
//  Created by Oleh Kiurchev on 23.05.2023.
//

import SwiftUI
import SwiftyDropbox
import ComposableArchitecture

struct AuthorizationClient {
    var authorize: () -> Void
}

private enum AuthorizationClientKey: DependencyKey {
    static let liveValue = AuthorizationClient(
        authorize: {
            let scopeRequest = ScopeRequest(scopeType: .user, scopes: ["account_info.read"], includeGrantedScopes: false)
            
            DropboxClientsManager.authorizeFromControllerV2(
                UIApplication.shared,
                controller: nil,
                loadingStatusDelegate: nil,
                openURL: { (url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil) },
                scopeRequest: scopeRequest
            )
        }
    )
}

extension DependencyValues {
    var authorizationClient: AuthorizationClient {
        get { self[AuthorizationClientKey.self] }
        set { self[AuthorizationClientKey.self] = newValue }
    }
}
