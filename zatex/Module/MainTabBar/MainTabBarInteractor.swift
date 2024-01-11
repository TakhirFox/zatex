//
//  MainTabBarMainTabBarInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol MainTabBarInteractorProtocol {
    func getStoreInfo(authorId: Int)
}

class MainTabBarInteractor: BaseInteractor {
    
    weak var presenter: MainTabBarPresenterProtocol?
    var service: ProfileAPI!
}

extension MainTabBarInteractor: MainTabBarInteractorProtocol {
    
    func getStoreInfo(authorId: Int) {
        self.service.fetchStoreInfo(authorId: authorId) { result in
            switch result {
            case let .success(data):
                self.presenter?.setStoreInfo(data: data)
                
            case .failure:
                break
            }
        }
    }
}
