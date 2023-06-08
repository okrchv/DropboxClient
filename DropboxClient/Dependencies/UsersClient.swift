//
//  UsersClient.swift
//  DropboxClient
//
//  Created by Oleh Kiurchev on 08.06.2023.
//

import Foundation
import SwiftyDropbox
import ComposableArchitecture

struct UsersClient {
    var getCurrentAccount: () async throws -> Users.FullAccount
}

struct UnauthorizedError: Error {}

private enum UsersClientKey: DependencyKey {
    static let liveValue = UsersClient(
        getCurrentAccount: {
            guard let client = DropboxClientsManager.authorizedClient else { throw UnauthorizedError() }
            return try await client.users.getCurrentAccount().dataTask
        }
    )
}

extension DependencyValues {
    var usersClient: UsersClient {
        get { self[UsersClientKey.self] }
        set { self[UsersClientKey.self] = newValue }
    }
}
