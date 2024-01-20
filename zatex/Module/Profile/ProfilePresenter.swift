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
    
    func getStoreProduct(
        authorId: Int,
        currentPage: Int,
        saleStatus: String
    )
    
    func setSalesProfuct(
        productId: Int,
        saleStatus: String,
        authorId: Int
    )
    
    func getProductStats(authorId: Int)
    func saveDeviceToken(authorId: Int)
    
    
    func goToSettings()
    func goToAuthView()
    func goToDetail(id: Int)
    func goToReview(id: String)
    
    
    func setStoreInfo(data: StoreInfoResult)
    func setStoreProduct(data: [ProductResult])
    func setProductStats(data: [ProductResult])
    func setError(data: String)
}

class ProfilePresenter: BasePresenter {
    
    enum Signal {
        case updateTabBarHandler
    }
    
    weak var view: ProfileViewControllerProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    var onSignal: (Signal) -> Void = { _ in }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    // MARK: To Interactor
    func getStoreInfo(authorId: Int) {
        interactor?.getStoreInfo(authorId: authorId)
    }
    
    func getStoreProduct(
        authorId: Int,
        currentPage: Int,
        saleStatus: String
    ) {
        interactor?.getStoreProduct(
            authorId: authorId,
            currentPage: currentPage,
            saleStatus: saleStatus
        )
    }
    
    func setSalesProfuct(
        productId: Int,
        saleStatus: String,
        authorId: Int
    ) {
        interactor?.setSalesProfuct(
            productId: productId,
            saleStatus: saleStatus,
            authorId: authorId
        )
        
        interactor?.getStoreStatsProduct(
            authorId: authorId
        )
    }
    
    func getProductStats(authorId: Int) {
        interactor?.getStoreStatsProduct(
            authorId: authorId
        )
    }
    
    func saveDeviceToken(authorId: Int) {
        let isSavedDeviceToken = UserDefaults.standard.bool(forKey: "isSavedDeviceToken")
        
        if !isSavedDeviceToken {
            let deviceToken = UserDefaults.standard.string(forKey: "deviceToken") ?? "CAN'T SAVE TOKEN"
            
            UserDefaults.standard.set(true, forKey: "isSavedDeviceToken")
            
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
            self?.onSignal(.updateTabBarHandler)
        })
    }
    
    func goToAuthView() {
        router?.routeToAuthView(signInHandler: { [weak self] in
            self?.view?.updateView()
            self?.onSignal(.updateTabBarHandler)
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
        view?.setStoreProduct(
            data: data
        )
    }
    
    func setProductStats(data: [ProductResult]) {
        let active = String(data.filter({ $0.saleStatus == .publish }).count)
        let sales = String(data.filter({ $0.saleStatus == .draft }).count)
        
        view?.setStats(activeCount: active, salesCount: sales)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
}
