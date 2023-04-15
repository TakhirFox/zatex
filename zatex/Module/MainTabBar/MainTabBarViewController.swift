//
//  MainTabBarMainTabBarViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol MainTabBarViewControllerProtocol: AnyObject {
    var presenter: MainTabBarPresenterProtocol? { get set }

}

class MainTabBarViewController: UITabBarController, MainTabBarViewControllerProtocol {
    
    var presenter: MainTabBarPresenterProtocol?
    
    override func viewDidLoad() {
        setTabbarAppereance()
        setupTabItems()
    }
    
    init(presenter: MainTabBarPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTabItems() {
        viewControllers = [
            createNavController(
                viewController: FeedAssembly.create(),
                title: "Feed",
                image: UIImage(named: "FeedIcon")!
            ),
            createNavController(
                viewController: CreateProductAssembly.create(),
                title: "Create",
                image: UIImage(named: "CreateIcon")!
            ),
            createNavController(
                viewController: ChatListAssembly.create(),
                title: "Chat",
                image: UIImage(named: "ChatIcon")!
            ),
            createNavController(
                viewController: ProfileAssembly.create(),
                title: "Profile",
                image: UIImage(named: "ProfileIcon")!
            )
        ]
    }
    
}

extension MainTabBarViewController {
    func createNavController(viewController: UIViewController,
                             title: String,
                             image: UIImage) -> UIViewController {
        let navConroller = UINavigationController(rootViewController: viewController)
        navConroller.tabBarItem.image = image
        viewController.navigationItem.title = title
        return navConroller
    }
    
    func setTabbarAppereance() {
        let customTabBar = BaseTabBar(frame: self.tabBar.bounds)
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
}
