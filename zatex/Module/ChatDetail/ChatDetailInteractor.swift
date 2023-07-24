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
    func markMessage(id: String)
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
            switch result {
            case let .success(data):
                self.presenter?.setChatMesssages(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setError(data: name)
                    
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
    
    func getChatInfo() {
        self.service.fetchChatInfo(
            chatId: chatId
        ) { result in
            switch result {
            case let .success(data):
                self.presenter?.setChatInfo(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setError(data: name)
                    
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
    
    func sendChatMessage(message: String) {
        self.service.sendChatMessage(
            chatId: chatId,
            message: message
        ) { result in
            switch result {
            case .success:
                self.getChatMessages()
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastError(text: name)
                }
            }
        }
    }
    
    func markMessage(id: String) {
        self.service.markMessage(messageId: id) { _ in }
    }
}
