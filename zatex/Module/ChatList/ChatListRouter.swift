//
//  ChatListChatListRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatListRouterProtocol: AnyObject {
    func routeToMessage(chatId: String)
}

class ChatListRouter: BaseRouter {
    weak var viewController: UIViewController?
}

extension ChatListRouter: ChatListRouterProtocol {
    
    func routeToMessage(chatId: String) {
        let view = ChatDetailAssembly.create(chatId: chatId)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
