//
//  MainTabBarMainTabBarPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol MainTabBarPresenterProtocol: AnyObject {

    func showAdditionalView()
}

class MainTabBarPresenter: BasePresenter {
    
    weak var view: MainTabBarViewControllerProtocol?
    var interactor: MainTabBarInteractorProtocol?
    var router: MainTabBarRouterProtocol?
    var closeViewHandler: (() -> Void) = {}
}

extension MainTabBarPresenter: MainTabBarPresenterProtocol {
    
    func showAdditionalView() {
        router?.routeToAdditionalInfo { [weak self] in
            self?.closeViewHandler()
        }
    }
}
