//
//  ResetPasswordAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.05.2023.
//

import Foundation

typealias ResetPasswordClosure = (Result<(), NetworkError>) -> (Void)

protocol ResetPasswordAPI {
    
    func fetchResetPassword(
        username: String,
        completion: @escaping ResetPasswordClosure
    ) -> (Void)
}
