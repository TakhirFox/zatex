//
//  NewsHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 29.11.2023.
//

import Alamofire

enum NewsHttpRouter {
    case getNewsList
}

extension NewsHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .getNewsList:
            return "/wp-json/news/v1/news"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getNewsList:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getNewsList:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getNewsList:
            return nil
        }
    }
    
    var requestInterceptor: RequestInterceptor? {
        return AccessTokenInterceptor(userSettingsService: UserSettingsService.shared)
    }
    
    func body() throws -> Data? {
        switch self {
        case .getNewsList:
            return nil
        }
    }
}
