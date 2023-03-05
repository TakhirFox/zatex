//
//  ChatDetailChatDetailPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol ChatDetailPresenterProtocol: AnyObject {

}

class ChatDetailPresenter: BasePresenter {
    weak var view: ChatDetailViewControllerProtocol?
    var interactor: ChatDetailInteractorProtocol?
    var router: ChatDetailRouterProtocol?
    
}

extension ChatDetailPresenter: ChatDetailPresenterProtocol {
    
}
