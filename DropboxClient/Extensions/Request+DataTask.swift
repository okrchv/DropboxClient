//
//  Request+DataTask.swift
//  DropboxClient
//
//  Created by Oleh Kiurchev on 08.06.2023.
//

import Foundation
import SwiftyDropbox

extension RpcRequest: DataTask {}
extension UploadRequest: DataTask {}
extension DownloadRequestFile: DataTask {}
