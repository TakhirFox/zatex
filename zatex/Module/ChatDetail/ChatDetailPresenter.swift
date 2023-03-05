//
//  ChatDetailChatDetailPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol ChatDetailPresenterProtocol: AnyObject {
    func getChatMessages()
    
    func setChatMesssages(data: [ChatMessageResult])
}

class ChatDetailPresenter: BasePresenter {
    weak var view: ChatDetailViewControllerProtocol?
    var interactor: ChatDetailInteractorProtocol?
    var router: ChatDetailRouterProtocol?
}

extension ChatDetailPresenter: ChatDetailPresenterProtocol {
    
    // MARK: To Interactor
    func getChatMessages() {
        interactor?.getChatMessages()
    }
    
    // MARK: To Router
    
    // MARK: To View
    func setChatMesssages(data: [ChatMessageResult]) {
        view?.setChatMesssages(data: data)
    }
}
