//
//  ChatDetailHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Alamofire

enum ChatDetailHttpRouter {
    case getChatMessage(chatId: String)
    case getChatInfo(chatId: String)
    case sendChatMessage(chatId: String, message: String)
    case markMessage(messageId: String)
}

extension ChatDetailHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case let .getChatMessage(chatId):
            return "/wp-json/chats/v1/chats/\(chatId)/messages"
            
        case let .getChatInfo(chatId):
            return "/wp-json/chats/v1/chats/\(chatId)/info"
            
        case let .sendChatMessage(chatId, _):
            return "/wp-json/chats/v1/chats/\(chatId)/messages"
            
        case let .markMessage(messageId):
            return "/wp-json/chats/v1/mark_message_as_read/\(messageId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getChatMessage:
            return .get
            
        case .getChatInfo:
            return .get
            
        case .sendChatMessage:
            return .post
            
        case .markMessage:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getChatMessage:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        case .getChatInfo:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        case .sendChatMessage:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
            
        case .markMessage:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getChatMessage:
            return [
                "page": 1,
                "per_page": 100
            ]
            
        case .getChatInfo,
                .sendChatMessage,
                .markMessage:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getChatMessage:
            return nil
            
        case .getChatInfo:
            return nil
            
        case let .sendChatMessage(_, message):
            let data = MessageRequest(content: message)
            return try JSONEncoder().encode(data)
            
        case .markMessage:
            return nil
        }
    }
}
