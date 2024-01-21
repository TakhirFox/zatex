//
//  ChatListChatListInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol ChatListInteractorProtocol {
    func getChatList(page: Int)
}

class ChatListInteractor: BaseInteractor {
    weak var presenter: ChatListPresenterProtocol?
    var service: ChatListAPI!
}

extension ChatListInteractor: ChatListInteractorProtocol {
    
    func getChatList(page: Int) {
        self.service.fetchChats(page: page) { result in
            switch result {
            case let .success(data):
                self.presenter?.setChatList(data: data)

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
}
