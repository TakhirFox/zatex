//
//  AdminPanelHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 15.01.2024.
//

import Alamofire

enum AdminPanelHttpRouter {
    case getUserList(page: Int)
}

extension AdminPanelHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .getUserList:
            return "/wp-json/dokan/v1/stores"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getUserList:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getUserList:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case let .getUserList(page):
            return [
                "per_page": 10,
                "page": page
            ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getUserList:
            return nil
        }
    }
}
