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
    
    case refresh(refreshToken: String)
}

extension AuthHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .authorization:
            return "wp-json/api-bearer-auth/v1/login"
            
        case .refresh:
            return "wp-json/api-bearer-auth/v1/tokens/refresh"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .authorization,
                .refresh:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .authorization,
                .refresh:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .authorization,
                .refresh:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case let .authorization(login, pass):
            
            let data = AuthRequest(
                username: login,
                password: pass,
                client_name: "zatexapp"
            )
            
            return try JSONEncoder().encode(data)
            
        case let .refresh(refreshToken):
            
            let data = RefreshRequest(
                token: refreshToken,
                client_name: "zatexapp"
            )
            
            return try JSONEncoder().encode(data)
        }
    }
}
