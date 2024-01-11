//
//  MainTabBarMainTabBarPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol MainTabBarPresenterProtocol: AnyObject {

    func getStoreInfo(authorId: Int)
    func setStoreInfo(data: StoreInfoResult)
}

class MainTabBarPresenter: BasePresenter {
    
    weak var view: MainTabBarViewControllerProtocol?
    var interactor: MainTabBarInteractorProtocol?
    var router: MainTabBarRouterProtocol?
    var closeViewHandler: (() -> Void) = {}
}

extension MainTabBarPresenter: MainTabBarPresenterProtocol {
    
    // MARK: To Interactor
    func getStoreInfo(authorId: Int) {
        interactor?.getStoreInfo(authorId: authorId)
    }
    
    // MARK: To View
    func setStoreInfo(data: StoreInfoResult) {
        guard let firstName = data.firstName,
              let lastName = data.lastName
        else { return }
        
        if firstName.isEmpty || lastName.isEmpty {
            router?.routeToAdditionalInfo { [weak self] in
                self?.closeViewHandler()
            }
        }
    }
}
