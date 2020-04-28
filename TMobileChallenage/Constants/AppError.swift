//
//  AppError.swift
//  TMobileChallenage
//
//  Created by Jason on 4/27/20.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

enum APPError: Error {
    case InvalidURL
    case NILHTTPResponse
    case DataNIL
    case DecodeError
}
