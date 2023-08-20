//
//  ChatDetailChatDetailRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatDetailRouterProtocol: AnyObject {
    
    func routeToProfile(id: String)
    func routeToProduct(id: String)
}

class ChatDetailRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension ChatDetailRouter: ChatDetailRouterProtocol {
    
    func routeToProfile(id: String) {
        let view = UserProfileAssembly.create(userId: Int(id)!)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToProduct(id: String) {
        let view = DetailAssembly.create(id: Int(id)!)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
