//
//  MainTabBarMainTabBarRouter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol MainTabBarRouterProtocol: AnyObject {
    
}

class MainTabBarRouter: BaseRouter {
    weak var viewController: UIViewController?
    
}

extension MainTabBarRouter: MainTabBarRouterProtocol {
    
}