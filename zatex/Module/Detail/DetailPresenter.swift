//
//  DetailPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol DetailPresenterProtocol: AnyObject {
    func getProductInfo()
    func getStoreInfo(authorId: Int)
    func checkChatExists(
        productAuthor: String,
        productId: String)
    
    func routeToMessage(chatId: String)
    func goToMapScreen(coordinates: CoordinareEntity)
    func goToDetail(id: Int)

    func setProductInfo(data: ProductResult)
    func setSimilarProducts(data: ProductResult)
    func setStoreInfo(data: StoreInfoResult)
}

class DetailPresenter: BasePresenter {
    
    weak var view: DetailViewControllerProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
}

extension DetailPresenter: DetailPresenterProtocol {
    
    // MARK: To Interactor
    func getProductInfo() {
        interactor?.getProductInfo()
    }
    
    func getStoreInfo(authorId: Int) {
        interactor?.getStoreInfo(authorId: authorId)
    }
    
    func checkChatExists(
        productAuthor: String,
        productId: String
    ) {
        interactor?.checkChatExists(productAuthor: productAuthor, productId: productId)
    }
    
    // MARK: To Router
    func routeToMessage(chatId: String) {
        router?.routeToMessage(chatId: chatId)
    }
    
    func goToMapScreen(coordinates: CoordinareEntity) {
        router?.routeToMap(coordinates: coordinates)
    }
    
    func goToDetail(id: Int) {
        router?.routeToDetail(id: id)
    }
    
    // MARK: To View
    func setProductInfo(data: ProductResult) {
        view?.setProductInfo(data: data)
        
        data.relatedIDS?.forEach({ id in
            interactor?.getSimilarProducts(productId: id)
        })
    }
    
    func setSimilarProducts(data: ProductResult) {
        view?.setSimilarProducts(data: data)
    }
    
    func setStoreInfo(data: StoreInfoResult) {
        view?.setStoreInfo(data: data)
    }
}
