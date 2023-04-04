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
        productAuthor: String,
        productId: String)
    func getCoordinates(address: String)
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
        productAuthor: String,
        productId: String
    ) {
        self.service.fetchCheckChat(
            productAuthor: productAuthor,
            productId: productId
        ) { result in
            self.presenter?.routeToMessage(chatId: result.chatID ?? "")
        }
    }
    
    func getCoordinates(address: String) {
        self.mapService.fetchCoordinates(address: address) { result in
            self.presenter?.routeToMap(coordinates: result)
        }
    }
}
