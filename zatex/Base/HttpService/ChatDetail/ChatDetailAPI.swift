//
//  ChatDetailAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import Foundation

typealias ChatMessageClosure = ([ChatMessageResult]) -> (Void)
typealias SendMessageClosure = (SendMessageResult) -> (Void)

protocol ChatDetailAPI {
    
    func fetchChatMessages(
        page: Int,
        chatId: String,
        completion: @escaping ChatMessageClosure
    ) -> (Void)
    
    func sendChatMessage(
        chatId: String,
        message: String,
        completion: @escaping SendMessageClosure
    ) -> Void
}
