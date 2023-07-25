//
//  ReviewsReviewsPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 20/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol ReviewsPresenterProtocol: AnyObject {
    func getReviews()
    func getStoreInfo()
    
    func setReviews(data: [ReviewsListResult])
    func setStoreInfo(data: StoreInfoResult)
    func setError(data: String)
}

class ReviewsPresenter: BasePresenter {
    weak var view: ReviewsViewControllerProtocol?
    var interactor: ReviewsInteractorProtocol?
    var router: ReviewsRouterProtocol?
    
}

extension ReviewsPresenter: ReviewsPresenterProtocol {
    
    // MARK: To Interactor
    func getReviews() {
        interactor?.getReviews()
    }
    
    func getStoreInfo() {
        interactor?.getStoreInfo()
    }
    
    // MARK: To View
    func setReviews(data: [ReviewsListResult]) {
        view?.setReviews(data: data)
    }
    
    func setStoreInfo(data: StoreInfoResult) {
        view?.setStoreInfo(data: data)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
}
