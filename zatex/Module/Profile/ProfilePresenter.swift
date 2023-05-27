//
//  ProfileProfilePresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol ProfilePresenterProtocol: AnyObject {
    func getStoreInfo(authorId: Int)
    func getStoreProduct(authorId: Int)

    func goToSettings()
    func goToAuthView()
    func goToDetail(id: Int)
    func goToReview(id: String)
    
    func setStoreInfo(data: StoreInfoResult)
    func setStoreProduct(data: [ProductResult])
}

class ProfilePresenter: BasePresenter {
    
    weak var view: ProfileViewControllerProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    var updateTabBarHandler: (() -> Void) = {}
}

extension ProfilePresenter: ProfilePresenterProtocol {
    // MARK: To Interactor
    func getStoreInfo(authorId: Int) {
        interactor?.getStoreInfo(authorId: authorId)
    }
    
    func getStoreProduct(authorId: Int) {
        interactor?.getStoreProduct(authorId: authorId)
    }
    
    // MARK: To Router
    func goToSettings() {
        router?.routeToSettings(logoutHandler: { [weak self] in
            self?.view?.updateView()
            self?.updateTabBarHandler()
        })
    }
    
    func goToAuthView() {
        router?.routeToAuthView(signInHandler: { [weak self] in
            self?.view?.updateView()
            self?.updateTabBarHandler()
        })
    }
    
    func goToDetail(id: Int) {
        router?.routeToDetail(id: id)
    }
    
    func goToReview(id: String) {
        router?.routeToReview(id: id)
    }
    
    // MARK: To View
    func setStoreInfo(data: StoreInfoResult) {
        view?.setStoreInfo(data: data)
    }
    
    func setStoreProduct(data: [ProductResult]) {
        view?.setStoreProduct(data: data)
    }
}
