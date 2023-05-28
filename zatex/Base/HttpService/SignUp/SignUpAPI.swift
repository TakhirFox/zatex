//
//  SignUpAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.05.2023.
//

import Foundation

typealias SignUpClosure = (SignUpResult) -> (Void)

protocol SignUpAPI {
    
    func fetchSignUp(
        username: String,
        email: String,
        pass: String,
        completion: @escaping SignUpClosure
    ) -> (Void)
}
