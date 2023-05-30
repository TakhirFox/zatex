//
//  ResetPasswordHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.05.2023.
//

import Alamofire

enum ResetPasswordHttpRouter {
    
    case resetPassword(username: String)
}

extension ResetPasswordHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://zakirovweb.online"
    }
    
    var path: String {
        switch self {
        case .resetPassword:
            return "/wp-json/wp/v2/users/lostpassword"
            
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .resetPassword:
            return .post
            
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .resetPassword:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
            
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .resetPassword:
            return nil
            
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case let .resetPassword(username):
            return try JSONEncoder().encode(
                ResetPasswordRequest(
                    userLogin: username
                )
            )
            
        }
    }
}
