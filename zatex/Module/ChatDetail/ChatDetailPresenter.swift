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
    
    func goToProfile(id: String)
    func goToProduct(id: String)
    
    func setChatMesssages(data: [ChatMessageResult])
    func setChatInfo(data: ChatInfoResult)
    func setError(data: String)
    func setToastError(text: String)
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
    func goToProfile(id: String) {
        router?.routeToProfile(id: id)
    }
    
    func goToProduct(id: String) {
        router?.routeToProduct(id: id)
    }
    
    // MARK: To View
    func setChatMesssages(data: [ChatMessageResult]) {
        interactor?.markMessage(id: data.last?.messageID ?? "")
        
        view?.setChatMesssages(data: data)
    }
    
    func setChatInfo(data: ChatInfoResult) {
        view?.setChatInfo(data: data)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
    
    func setToastError(text: String) {
        view?.showToastError(text: text)
    }
}
