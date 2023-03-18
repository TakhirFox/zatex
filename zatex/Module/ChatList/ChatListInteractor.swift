//
//  ChatListChatListInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol ChatListInteractorProtocol {
    func getChatList()
}

class ChatListInteractor: BaseInteractor {
    weak var presenter: ChatListPresenterProtocol?
    var service: ChatListAPI!
}

extension ChatListInteractor: ChatListInteractorProtocol {
    
    func getChatList() {
        self.service.fetchChats { result in
            self.presenter?.setChatList(data: result)
        }
    }
}
