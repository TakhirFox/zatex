//
//  ReviewsReviewsPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 20/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol ReviewsPresenterProtocol: AnyObject {

}

class ReviewsPresenter: BasePresenter {
    weak var view: ReviewsViewControllerProtocol?
    var interactor: ReviewsInteractorProtocol?
    var router: ReviewsRouterProtocol?
    
}

extension ReviewsPresenter: ReviewsPresenterProtocol {
    
}
