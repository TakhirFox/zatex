//
//  ChatDetailAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Foundation

typealias ChatMessageClosure = ([ChatMessageResult]) -> (Void)
typealias ChatInfoClosure = (ChatInfoResult) -> (Void)
typealias SendMessageClosure = (SendMessageResult) -> (Void)
typealias MarkMessageClosure = () -> (Void)

protocol ChatDetailAPI {
    
    func fetchChatMessages(
        page: Int,
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
