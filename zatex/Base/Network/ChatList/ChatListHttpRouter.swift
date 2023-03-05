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
                "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3pha2lyb3Z3ZWIub25saW5lIiwiaWF0IjoxNjc4MDIzMjUzLCJuYmYiOjE2NzgwMjMyNTMsImV4cCI6MTY3ODYyODA1MywiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMSJ9fX0.NnFF6rMeOtv4W3i0KGvSWH8pEFXahEg_Opvj3tJOGJM" //TODO: token?
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
