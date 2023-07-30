//
//  NetworkError.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.07.2023.
//

import Foundation

enum NetworkError: Error {
    case error(name: String)
    case secondError(name: String)
}
