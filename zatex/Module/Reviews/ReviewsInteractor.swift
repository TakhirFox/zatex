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
            switch result {
            case let .success(data):
                self.presenter?.setReviews(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    if name == "Пустой" {
                        self.presenter?.setReviews(data: [])
                    } else {
                        self.presenter?.setError(data: name)
                    }
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
    
    func getStoreInfo() {
        self.service.fetchStoreInfo(authorId: id) { result in
            switch result {
            case let .success(data):
                self.presenter?.setStoreInfo(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setError(data: name)
                    
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
}
