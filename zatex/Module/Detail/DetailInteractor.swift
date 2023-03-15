//
//  DetailInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol DetailInteractorProtocol {
    func getProductInfo()
    func getStoreInfo(authorId: Int)
    func checkChatExists(
        productAuthor: String,
        productId: String)
}

class DetailInteractor: BaseInteractor {
    weak var presenter: DetailPresenterProtocol?
    var service: ProductDetailAPI!
    var productId = ""
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
}
