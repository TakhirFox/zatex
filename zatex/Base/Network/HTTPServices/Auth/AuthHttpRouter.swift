//
//  AuthHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.03.2023.
//

import Alamofire

enum AuthHttpRouter {
    case authorization(
        login: String,
        pass: String
    )
}

extension AuthHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .authorization:
            return "/wp-json/jwt-auth/v1/token"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .authorization:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .authorization:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .authorization:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case let .authorization(login, pass):
            
            let data = AuthRequest(
                username: login,
                password: pass
            )
            
            return try JSONEncoder().encode(data)
        }
    }
}
