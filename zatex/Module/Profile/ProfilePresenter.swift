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
    func goToDetail(id: String)
    
    func setStoreInfo(data: StoreInfoResult)
    func setStoreProduct(data: [ProductResult])
}

class ProfilePresenter: BasePresenter {
    weak var view: ProfileViewControllerProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    
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
        router?.routeToSettings()
    }
    
    func goToAuthView() {
        router?.routeToAuthView()
    }
    
    func goToDetail(id: String) {
        router?.routeToDetail(id: id)
    }
    
    // MARK: To View
    func setStoreInfo(data: StoreInfoResult) {
        view?.setStoreInfo(data: data)
    }
    
    func setStoreProduct(data: [ProductResult]) {
        view?.setStoreProduct(data: data)
    }
}
