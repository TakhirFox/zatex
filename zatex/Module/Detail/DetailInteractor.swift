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
    
    func getFavoriteList()
    func addFavorite(productId: Int)
    func removeFavorite(productId: Int)
}

class DetailInteractor: BaseInteractor {
    
    weak var presenter: DetailPresenterProtocol?
    var service: ProductDetailAPI!
    var mapService: MapAPI!
    var favoriteService: FavoritesAPI!
    var productId = 0
}

extension DetailInteractor: DetailInteractorProtocol {
    
    func getProductInfo() {
        self.service.fetchProductInfo(productId: productId) { result in
            switch result {
            case let .success(data):
                self.presenter?.setProductInfo(data: data)
                
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
    
    func getStoreInfo(authorId: Int) {
        self.service.fetchStoreInfo(authorId: authorId) { result in
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
    
    func getSimilarProducts(productId: Int) {
        self.service.fetchProductInfo(productId: productId) { result in
            switch result {
            case let .success(data):
                self.presenter?.setSimilarProducts(data: data)
                
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
    
    func checkChatExists(
        productAuthor: Int,
        productId: Int
    ) {
        self.service.fetchCheckChat(
            productAuthor: productAuthor,
            productId: productId
        ) { result in
            switch result {
            case let .success(data):
                self.presenter?.routeToMessage(chatId: data.chatID ?? "")
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastError(text: name, type: .checkChatExists)
                    
                case let .secondError(name):
                    self.presenter?.setToastError(text: name, type: .checkChatExists)
                }
            }
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
            switch result {
            case let .success(data):
                self.presenter?.showReviewButton(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastError(text: name, type: .checkStartChat)
                    
                case let .secondError(name):
                    self.presenter?.setToastError(text: name, type: .checkStartChat)
                }
            }
        }
    }
    
    func getCoordinates(address: String) {
        self.mapService.directGeocoding(address: address) { result in
            switch result {
            case let .success(data):
                self.presenter?.routeToMap(coordinates: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setMapError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setMapError(text: name)
                }
            }
        }
    }
    
    func sendReview(
        id: Int,
        review: ReviewEntity
    ) {
        self.service.sendReview(id: id, review: review) { result in
            switch result {
            case .success:
                self.presenter?.showSuccessReview()
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastError(text: name, type: .sendReview)
                    
                case let .secondError(name):
                    self.presenter?.setToastError(text: name, type: .sendReview)
                }
            }
        }
    }
}

extension DetailInteractor {
    
    func getFavoriteList() {
        self.favoriteService.fetchFavoriteList { result in
            switch result {
            case let .success(data):
                self.presenter?.setFavoriteList(data: data)
                
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
    
    func addFavorite(productId: Int) {
        self.favoriteService.addFavorite(productId: productId) { result in
            switch result {
            case .success:
                break
                
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
    
    func removeFavorite(productId: Int) {
        self.favoriteService.removeFavorite(productId: productId) { result in
            switch result {
            case .success:
                break
                
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
