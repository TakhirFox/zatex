//
//  ChatDetailChatDetailInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol ChatDetailInteractorProtocol {
    func getChatMessages()
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
}
