//
//  ProfileProfilePresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func getStoreInfo(authorId: Int)
    func getStoreProduct(authorId: Int, isSales: Bool)
    func setSalesProfuct(productId: Int, isSales: Bool, authorId: Int)
    func getProductStats(authorId: Int)
    func saveDeviceToken(authorId: Int)
    
    func goToSettings()
    func goToAuthView()
    func goToDetail(id: Int)
    func goToReview(id: String)
    
    func setStoreInfo(data: StoreInfoResult)
    func setStoreProduct(data: [ProductResult], isSales: Bool)
    func setProductStats(data: [ProductResult])
    func setError(data: String)
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
    
    func getStoreProduct(
        authorId: Int,
        isSales: Bool
    ) {
        interactor?.getStoreProduct(
            authorId: authorId,
            isSales: isSales
        )
    }
    
    func setSalesProfuct(
        productId: Int,
        isSales: Bool,
        authorId: Int
    ) {
        interactor?.setSalesProfuct(
            productId: productId,
            isSales: isSales,
            authorId: authorId
        )
    }
    
    func getProductStats(authorId: Int) {
        interactor?.getStoreProduct(
            authorId: authorId,
            isSales: false
        )
    }
    
    func saveDeviceToken(authorId: Int) {
        let isSavedDeviceToken = UserDefaults.standard.bool(forKey: "isSavedDeviceToken")
        
        if !isSavedDeviceToken {
            let deviceToken = UserDefaults.standard.string(forKey: "deviceToken") ?? "CAN'T SAVE TOKEN"
            
            interactor?.saveDeviceToken(
                authorId: authorId,
                deviceToken: deviceToken
            )
        }
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
    
    func setStoreProduct(data: [ProductResult], isSales: Bool) {
        view?.setStoreProduct(
            data: data,
            isSales: isSales
        )
    }
    
    func setProductStats(data: [ProductResult]) {
        let active = String(data.filter({ $0.isSales == false }).count)
        let sales = String(data.filter({ $0.isSales == true }).count)
        
        view?.setStats(activeCount: active, salesCount: sales)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
}
