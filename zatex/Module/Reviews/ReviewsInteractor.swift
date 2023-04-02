//
//  ReviewsReviewsInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 20/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol ReviewsInteractorProtocol {
    func getReviews()
    func getStoreInfo()
}

class ReviewsInteractor: BaseInteractor {
    weak var presenter: ReviewsPresenterProtocol?
    var service: ReviewsAPI!
    var id = ""
}

extension ReviewsInteractor: ReviewsInteractorProtocol {
    
    func getReviews() {
        self.service.fetchReviews(authorId: id) { result in
            self.presenter?.setReviews(data: result)
        }
    }
    
    func getStoreInfo() {
        self.service.fetchStoreInfo(authorId: id) { result in
            self.presenter?.setStoreInfo(data: result)
        }
    }
}
