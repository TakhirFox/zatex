//
//  UserProfileUserProfilePresenter.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol UserProfilePresenterProtocol: AnyObject {
    func getStoreInfo(authorId: Int)
    func getStoreProduct(authorId: Int, isSales: Bool)
    
    func goToDetail(id: Int)
    func goToReview(id: String)
    
    func setStoreInfo(data: StoreInfoResult)
    func setStoreProduct(data: [ProductResult], isSales: Bool)
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
        isSales: Bool
    ) {
        interactor?.getStoreProduct(
            authorId: authorId,
            isSales: isSales
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
    
    func setStoreProduct(data: [ProductResult], isSales: Bool) {
        view?.setStoreProduct(
            data: data,
            isSales: isSales
        )
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
}
