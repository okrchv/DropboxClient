//
//  CallError+Error.swift
//  DropboxClient
//
//  Created by Oleh Kiurchev on 08.06.2023.
//

import Foundation
import SwiftyDropbox

extension CallError: Error {
    var localizedDescription: String {
        return self.description
    }
}
