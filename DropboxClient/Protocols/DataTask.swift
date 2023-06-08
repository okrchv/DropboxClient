//
//  DataTask.swift
//  DropboxClient
//
//  Created by Oleh Kiurchev on 08.06.2023.
//

import Foundation

protocol DataTask {
    associatedtype ValueType
    associatedtype ErrorType: Error

    func response(
        queue: DispatchQueue?,
        completionHandler: @escaping (ValueType?, ErrorType?) -> Void
    ) -> Self
}

extension DataTask {
    var dataTask: ValueType {
        get async throws {
            return try await withCheckedThrowingContinuation({ continuation in
                _ = self.response(queue: nil) { response, error in
                    if let response = response {
                        continuation.resume(returning: response)
                    } else if let error = error {
                        continuation.resume(throwing: error)
                    }
                }
            })
        }
    }
}
