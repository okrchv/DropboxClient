//
//  Users.FullAccount+Equatable.swift
//  DropboxClient
//
//  Created by Oleh Kiurchev on 08.06.2023.
//

import Foundation
import SwiftyDropbox

extension Users.FullAccount: Equatable {
    public static func == (lhs: SwiftyDropbox.Users.FullAccount, rhs: SwiftyDropbox.Users.FullAccount) -> Bool {
        lhs.accountId == rhs.accountId
    }
}
