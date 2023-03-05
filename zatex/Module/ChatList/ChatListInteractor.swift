//
//  ChatListChatListInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol ChatListInteractorProtocol {
    
}

class ChatListInteractor: BaseInteractor, ChatListInteractorProtocol {
    weak var presenter: ChatListPresenterProtocol?

}