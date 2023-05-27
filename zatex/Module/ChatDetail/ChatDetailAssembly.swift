//
//  ChatDetailChatDetailAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class ChatDetailAssembly {
    static func create(chatId: String) -> UIViewController {
        let viewController = ChatDetailViewController()
        let presenter = ChatDetailPresenter()
        let interactor = ChatDetailInteractor()
        let router = ChatDetailRouter()
        
        let networkService = ChatDetailService.shared
        let sessionProvider = AppSessionProvider()
        
        viewController.presenter = presenter
        viewController.userId = sessionProvider.getSession()?.userId
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = networkService
        interactor.chatId = chatId
        
        router.viewController = viewController
        
        return viewController
    }
    
}
