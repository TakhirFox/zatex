//
//  ChatListHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Alamofire

enum ChatListHttpRouter {
    case getChatList(page: Int)
}

extension ChatListHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .getChatList:
            return "/wp-json/chats/v1/chats"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getChatList:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getChatList:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case let .getChatList(page):
            return [
                "page": page,
                "per_page": 10
            ]
        }
    }
    
    var requestInterceptor: RequestInterceptor? {
        return AccessTokenInterceptor(userSettingsService: UserSettingsService.shared)
    }
    
    func body() throws -> Data? {
        switch self {
        case .getChatList:
            return nil
        }
    }
}
