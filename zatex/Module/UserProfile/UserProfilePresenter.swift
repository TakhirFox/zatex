//
//  UserProfileUserProfilePresenter.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol UserProfilePresenterProtocol: AnyObject {
    func getStoreInfo(authorId: Int)
    
    func getStoreProduct(
        authorId: Int,
        currentPage: Int,
        saleStatus: String
    )
    
    func getProductStats(authorId: Int)
    
    
    func goToDetail(id: Int)
    func goToReview(id: String)
    
    
    func setStoreInfo(data: StoreInfoResult)
    func setStoreProduct(data: [ProductResult])
    func setProductStats(data: [ProductResult])
    func setError(data: String)
}

class UserProfilePresenter: BasePresenter {
    weak var view: UserProfileViewControllerProtocol?
    var interactor: UserProfileInteractorProtocol?
    var router: UserProfileRouterProtocol?
    
}

extension UserProfilePresenter: UserProfilePresenterProtocol {
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
    
    func getProductStats(authorId: Int) {
        interactor?.getStoreStatsProduct(
            authorId: authorId
        )
    }
    
    // MARK: To Router
    
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
