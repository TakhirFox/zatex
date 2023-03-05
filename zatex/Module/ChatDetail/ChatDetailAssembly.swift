//
//  ChatDetailChatDetailAssembly.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

class ChatDetailAssembly: BaseAssemblyProtocol {
    static func create() -> UIViewController {
        let viewController = ChatDetailViewController()
        let presenter = ChatDetailPresenter()
        let interactor = ChatDetailInteractor()
        let router = ChatDetailRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
}