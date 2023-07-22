//
//  ChatDetailChatDetailPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol ChatDetailPresenterProtocol: AnyObject {
    func getChatMessages()
    func getChatInfo()
    func sendChatMessage(message: String)
    
    func setChatMesssages(data: [ChatMessageResult])
    func setChatInfo(data: ChatInfoResult)
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
    
    func getChatInfo() {
        interactor?.getChatInfo()
    }
    
    func sendChatMessage(message: String) {
        interactor?.sendChatMessage(message: message)
    }
    
    // MARK: To Router
    
    // MARK: To View
    func setChatMesssages(data: [ChatMessageResult]) {
        interactor?.markMessage(id: data.last?.messageID ?? "")
        
        view?.setChatMesssages(data: data)
    }
    
    func setChatInfo(data: ChatInfoResult) {
        view?.setChatInfo(data: data)
    }
}
