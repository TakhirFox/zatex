//
//  MainTabBarMainTabBarInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol MainTabBarInteractorProtocol {
    
}

class MainTabBarInteractor: BaseInteractor {
    
    weak var presenter: MainTabBarPresenterProtocol?
}

extension MainTabBarInteractor: MainTabBarInteractorProtocol {}
