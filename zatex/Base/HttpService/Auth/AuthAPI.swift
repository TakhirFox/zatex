//
//  AuthAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.03.2023.
//

import Foundation

typealias AuthClosure = (Result<AuthResult, NetworkError>) -> (Void)

protocol AuthAPI {
    
    func fetchAuthorization(
        login: String,
        pass: String,
        completion: @escaping AuthClosure
    ) -> (Void)
}
