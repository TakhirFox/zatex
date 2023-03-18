//
//  ChatListHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Alamofire

enum ChatListHttpRouter {
    case getChatList
}

extension ChatListHttpRouter: HttpRouter {
    
    private var token: String {
        return UserSettingsService.shared.token
    }
    
    var baseUrlString: String {
        return "https://zakirovweb.online"
    }
    
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
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getChatList:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getChatList:
            return nil
        }
    }
}
