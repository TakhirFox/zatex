//
//  MainTabBarMainTabBarPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol MainTabBarPresenterProtocol: AnyObject {

}

class MainTabBarPresenter: BasePresenter {
    weak var view: MainTabBarViewControllerProtocol?
    var interactor: MainTabBarInteractorProtocol?
    var router: MainTabBarRouterProtocol?
    
}

extension MainTabBarPresenter: MainTabBarPresenterProtocol {
    
}
