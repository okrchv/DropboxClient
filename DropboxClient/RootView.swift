//
//  RootView.swift
//  DropboxClient
//
//  Created by Oleh Kiurchev on 31.05.2023.
//

import SwiftUI
import SwiftyDropbox
import ComposableArchitecture

struct Root: ReducerProtocol {
    struct State: Equatable {
    }

    enum Action: Equatable {
        case authButtonTapped
        case authSuccessful
        case authCancelledByUser
        case authFailed
        case getCurrentAccount
        case getCurrentAccountResponse(TaskResult<Users.FullAccount>)
    }

    @Dependency(\.authorizationClient) var authorization
    @Dependency(\.usersClient) var users
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .authButtonTapped:
            self.authorization.authorize()
            return .none
        case .authSuccessful:
            return .send(.getCurrentAccount)
        case .authCancelledByUser:
            return .none
        case .authFailed:
            return .none
        case .getCurrentAccount:
            return .run { send in
                await send(
                    .getCurrentAccountResponse(
                        TaskResult { try await self.users.getCurrentAccount() }
                    )
                )
            }
        case let .getCurrentAccountResponse(.success(currentAccount)):
            print(currentAccount)
            return .none
        case .getCurrentAccountResponse(.failure(_)):
            return .none
        }
    }
}

struct RootView: View {
    let store: StoreOf<Root>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Spacer()
            VStack {
                Button("Log In") { viewStore.send(.authButtonTapped) }
            }
            Spacer()
            .onOpenURL { url in
                let oauthCompletion: DropboxOAuthCompletion = {
                    if let authResult = $0 {
                        switch authResult {
                        case .success:
                            viewStore.send(.authSuccessful)
                            print("Success! User is logged into DropboxClientsManager.")
                        case .cancel:
                            viewStore.send(.authCancelledByUser)
                            print("Authorization flow was manually canceled by user!")
                        case .error(_, let description):
                            viewStore.send(.authFailed)
                            print("Error: \(String(describing: description))")
                        }
                    }
                }
                DropboxClientsManager.handleRedirectURL(url, completion: oauthCompletion)
            }
        }
    }
}
