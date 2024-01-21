//
//  ChatListChatListPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol ChatListPresenterProtocol: AnyObject {
    
    func getChatList(page: Int)
    
    func routeToMessage(chatId: String?)
    
    func setChatList(data: [ChatListResult])
    func setError(data: String)
}

class ChatListPresenter: BasePresenter {
    weak var view: ChatListViewControllerProtocol?
    var interactor: ChatListInteractorProtocol?
    var router: ChatListRouterProtocol?
}

extension ChatListPresenter: ChatListPresenterProtocol {
    
    // MARK: To Interactor
    func getChatList(page: Int) {
        interactor?.getChatList(page: page)
    }
    
    // MARK: To Router
    func routeToMessage(chatId: String?) {
        guard let chatId = chatId else { return }
        router?.routeToMessage(chatId: chatId)
    }
    
    // MARK: To View
    func setChatList(data: [ChatListResult]) {
        view?.setChatList(data: data)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
}
