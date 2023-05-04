//
//  DetailInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol DetailInteractorProtocol {
    func getProductInfo()
    func getSimilarProducts(productId: Int)
    func getStoreInfo(authorId: Int)
    
    func checkChatExists(
        productAuthor: Int,
        productId: Int
    )
    
    func checkStartChat(
        productAuthor: Int,
        productId: Int
    )
    
    func getCoordinates(address: String)
    
    func sendReview(
        id: Int,
        review: ReviewEntity
    )
}

class DetailInteractor: BaseInteractor {
    weak var presenter: DetailPresenterProtocol?
    var service: ProductDetailAPI!
    var mapService: MapAPI!
    var productId = 0
}

extension DetailInteractor: DetailInteractorProtocol {
    
    func getProductInfo() {
        self.service.fetchProductInfo(productId: productId) { result in
            self.presenter?.setProductInfo(data: result)
        }
    }
    
    func getStoreInfo(authorId: Int) {
        self.service.fetchStoreInfo(authorId: authorId) { result in
            self.presenter?.setStoreInfo(data: result)
        }
    }
    
    func getSimilarProducts(productId: Int) {
        self.service.fetchProductInfo(productId: productId) { result in
            self.presenter?.setSimilarProducts(data: result)
        }
    }
    
    func checkChatExists(
        productAuthor: Int,
        productId: Int
    ) {
        self.service.fetchCheckChat(
            productAuthor: productAuthor,
            productId: productId
        ) { result in
            self.presenter?.routeToMessage(chatId: result.chatID ?? "")
        }
    }
    
    func checkStartChat(
        productAuthor: Int,
        productId: Int
    ) {
        self.service.fetchCheckChatToReview(
            productAuthor: productAuthor,
            productId: productId
        ) { result in
            self.presenter?.showReviewButton(data: result)
        }
    }
    
    func getCoordinates(address: String) {
        self.mapService.fetchCoordinates(address: address) { result in
            self.presenter?.routeToMap(coordinates: result)
        }
    }
    
    func sendReview(
        id: Int,
        review: ReviewEntity
    ) {
        self.service.sendReview(id: id, review: review) {
            self.presenter?.showSuccessReview()
        }
    }
}
