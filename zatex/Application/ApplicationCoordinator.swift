//
//  ApplicationCoordinator.swift
//  zatex
//
//  Created by Zakirov Tahir on 27.05.2023.
//

import UIKit

class ApplicationCoordinator {
    
    private let tabbarRouter = MainTabBarRouter()
    
    private var window: UIWindow?
    
    func start(_ window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
        
        window.rootViewController = MainTabBarAssembly.create(with: tabbarRouter)
    }
}

extension ApplicationCoordinator {
    
    func showDeeplink(deeplinkType: DeepLinkType) {
        tabbarRouter.routeWithDeeplink(type: deeplinkType)
    }
}
