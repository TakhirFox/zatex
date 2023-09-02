//
//  SignUpHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.05.2023.
//

import Alamofire

enum SignUpHttpRouter {
    case signUp(
        username: String,
        email: String,
        password: String
    )
}

extension SignUpHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .signUp:
            return "/wp-json/wp/v2/users/register"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .signUp:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .signUp:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .signUp:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case let .signUp(username, email, pass):
            let data = SignUpRequest(
                username: username,
                email: email,
                password: pass,
                role: "seller")
            
            return try JSONEncoder().encode(data)
        }
    }
}
