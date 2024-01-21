//
//  ChatDetailAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Foundation

typealias ChatMessageClosure = (Result<[ChatMessageResult], NetworkError>) -> (Void)
typealias ChatInfoClosure = (Result<ChatInfoResult, NetworkError>) -> (Void)
typealias SendMessageClosure = (Result<SendMessageResult, NetworkError>) -> (Void)
typealias MarkMessageClosure = (Result<(), NetworkError>) -> (Void)

protocol ChatDetailAPI {
    
    func fetchChatMessages(
        chatId: String,
        completion: @escaping ChatMessageClosure
    ) -> (Void)
    
    func fetchChatInfo(
        chatId: String,
        completion: @escaping ChatInfoClosure
    ) -> (Void)
    
    func sendChatMessage(
        chatId: String,
        message: String,
        completion: @escaping SendMessageClosure
    ) -> Void
    
    func markMessage(
        messageId: String,
        completion: @escaping MarkMessageClosure
    ) -> Void
}
