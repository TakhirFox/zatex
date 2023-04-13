//
//  ChatDetailChatDetailInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol ChatDetailInteractorProtocol {
    func getChatMessages()
    func getChatInfo()
    func sendChatMessage(message: String)
}

class ChatDetailInteractor: BaseInteractor {
    weak var presenter: ChatDetailPresenterProtocol?
    var service: ChatDetailAPI!
    var chatId = ""
}

extension ChatDetailInteractor: ChatDetailInteractorProtocol {
    
    func getChatMessages() {
        self.service.fetchChatMessages(
            page: 0,
            chatId: chatId
        ) { result in // TODO: page: 0 to dynamic
            self.presenter?.setChatMesssages(data: result)
        }
    }
    
    func getChatInfo() {
        self.service.fetchChatInfo(
            chatId: chatId
        ) { result in
            self.presenter?.setChatInfo(data: result)
        }
    }
    
    func sendChatMessage(message: String) {
        self.service.sendChatMessage(
            chatId: chatId,
            message: message
        ) { result in
            self.getChatMessages()
        }
    }
}
