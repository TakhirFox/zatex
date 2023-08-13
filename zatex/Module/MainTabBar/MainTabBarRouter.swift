//
//  MainTabBarMainTabBarRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol MainTabBarRouterProtocol: AnyObject {
    
    func routeWithDeeplink(type: DeepLinkType)
}

class MainTabBarRouter: BaseRouter {
    weak var viewController: UITabBarController?
}

extension MainTabBarRouter: MainTabBarRouterProtocol {
    
    func routeWithDeeplink(type: DeepLinkType) {
        guard let selectedViewController = viewController?.selectedViewController as? UINavigationController else { return }
        
        switch type {
        case .product(let id):
            let view = DetailAssembly.create(id: id)
            selectedViewController.pushViewController(view, animated: true)
            
        case .profile(let id):
            let view = ProfileAssembly.create {}
            selectedViewController.pushViewController(view, animated: true)
        }
    }
}
