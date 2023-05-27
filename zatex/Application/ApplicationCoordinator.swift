//
//  ApplicationCoordinator.swift
//  zatex
//
//  Created by Zakirov Tahir on 27.05.2023.
//

import UIKit

class ApplicationCoordinator {
    private var window: UIWindow?
    
    func start(_ window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
        
        window.rootViewController = MainTabBarAssembly.create()
    }
}
