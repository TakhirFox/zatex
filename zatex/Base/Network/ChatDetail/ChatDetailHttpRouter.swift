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
}

extension ChatDetailHttpRouter: HttpRouter {
    
    var baseUrlString: String {
        return "https://zakirovweb.online"
    }
    
    var path: String {
        switch self {
        case let .getChatMessage(chatId):
            return "/wp-json/chats/v1/chats/\(chatId)/messages"
        case let .getChatInfo(chatId):
            return "/wp-json/chats/v1/chats/\(chatId)/info"
        case let .sendChatMessage(chatId, _):
            return "/wp-json/chats/v1/chats/\(chatId)/messages"
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
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getChatMessage,
                .getChatInfo,
                .sendChatMessage:
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
            let data = ASdas(content: message) //TODO: Change
            return try JSONEncoder().encode(data)
        }
    }
}

struct ASdas: Encodable { //TODO: Change
    let content: String
}
