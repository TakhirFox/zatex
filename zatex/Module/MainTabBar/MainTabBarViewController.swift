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
    private var sessionProvider: SessionProvider
    
    private var favoritesController: UIViewController?
    private var chatController: UIViewController?
    private var createProductController: UIViewController?
    
    override func viewDidLoad() {
        setTabbarAppereance()
        setupTabItems()
        
        DispatchQueue.main.async {
            guard let id = self.sessionProvider.getSession()?.user.id else { return }
            self.presenter?.getStoreInfo(authorId: id)
        }
    }
    
    init(
        presenter: MainTabBarPresenterProtocol,
        sessionProvider: SessionProvider
    ) {
        self.presenter = presenter
        self.sessionProvider = sessionProvider
        
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
                viewController: ProfileAssembly.create { [weak self] signal in
                    switch signal {
                    case .updateTabBarHandler:
                        self?.addChatView()
                    }
                },
                title: "Profile",
                image: UIImage(named: "ProfileIcon")!
            )
        ]
        
        
        self.addChatView()
    }
    
    private func addChatView() {
        if sessionProvider.isAuthorized {
            favoritesController = createNavController(
                viewController: FavoritesAssembly.create(),
                title: "Favorites",
                image: UIImage(named: "FavoritesIcon")!
            )
            
            createProductController = createNavController(
                viewController: CreateProductAssembly.create(),
                title: "Create",
                image: UIImage(named: "CreateIcon")!
            )
            
            chatController = createNavController(
                viewController: ChatListAssembly.create(),
                title: "Chat",
                image: UIImage(named: "ChatIcon")!
            )
            
            viewControllers?.insert(favoritesController!, at: 1)
            viewControllers?.insert(createProductController!, at: 2)
            viewControllers?.insert(chatController!, at: 3)
        } else {
            guard createProductController != nil,
                  chatController != nil,
                  favoritesController != nil
            else { return }
            
            if let viewControllers = viewControllers,
               viewControllers.contains(createProductController!),
               viewControllers.contains(chatController!),
               viewControllers.contains(favoritesController!){
                
                self.viewControllers?.remove(at: 3)
                self.viewControllers?.remove(at: 2)
                self.viewControllers?.remove(at: 1)
            }
        }
    }
}

extension MainTabBarViewController {
    
    func createNavController(
        viewController: UIViewController,
        title: String,
        image: UIImage
    ) -> UIViewController {
        let navConroller = BaseNavigationController(rootViewController: viewController)
        navConroller.tabBarItem.image = image
        viewController.navigationItem.title = title
        return navConroller
    }
    
    func setTabbarAppereance() {
        let customTabBar = BaseTabBar(frame: self.tabBar.bounds)
        self.setValue(customTabBar, forKey: "tabBar")
    }
}
