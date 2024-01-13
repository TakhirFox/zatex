//
//  DetailPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol DetailPresenterProtocol: AnyObject {
    
    // Interactor
    func getProductInfo()
    func getStoreInfo(authorId: Int)
    
    func checkChatExists(
        productAuthor: Int,
        productId: Int)
    
    func checkStartChat(
        productAuthor: Int,
        productId: Int)
    
    func callPhone(number: String?)
    func getCoordinatesAndGoToMap(address: ProductResult.AddressUnion?)
    
    func sendReview(
        userId: Int?,
        productName: String?,
        content: String?,
        rating: Int?
    )
    
    func addFavorite(productId: Int)
    func removeFavorite(productId: Int)
    
    // Router
    func routeToMessage(chatId: String)
    func routeToMap(coordinates: [CoordinatesResult])
    func goToDetail(id: Int)
    func goToProfile(id: Int)
    
    func goToFullscreen(
        images: [ProductResult.Image]?,
        selected: Int
    )
    
    // View
    func setProductInfo(data: ProductResult)
    func setSimilarProducts(data: ProductResult)
    func setStoreInfo(data: StoreInfoResult)
    func setFavoriteList(data: [FavoriteResponse])
    func showSuccessReview()
    func showReviewButton(data: CheckChatReviewResult)
    func setError(data: String)
    func setToastError(text: String, type: ToastErrorKind)
    func setMapError(text: String)
}

enum ToastErrorKind {
    case checkChatExists
    case checkStartChat
    case sendReview
    case addFavorite
    case removeFvorite
}

class DetailPresenter: BasePresenter {
    
    weak var view: DetailViewControllerProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    var sessionProvider: SessionProvider!
    private var productEntities: [ProductResult] = []
    private var productEntity: ProductResult?
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
        productAuthor: Int,
        productId: Int
    ) {
        interactor?.checkChatExists(
            productAuthor: productAuthor,
            productId: productId
        )
    }
    
    func checkStartChat(
        productAuthor: Int,
        productId: Int
    ) {
        if sessionProvider.isAuthorized {
            interactor?.checkStartChat(
                productAuthor: productAuthor,
                productId: productId
            )
        }
    }
    
    func callPhone(number: String?) {
        if number != nil {
            if let url = URL(string: "tel://\(number!)"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func getCoordinatesAndGoToMap(address: ProductResult.AddressUnion?) {
        switch address {
        case .address(let address):
            let street = address.street1 ?? ""
            let city = address.city ?? ""
            let country = address.country ?? ""
            
            interactor?.getCoordinates(address: "\(country), \(city), \(street)")
            
        case .empty, nil:
            return
        }
    }
    
    func sendReview(
        userId: Int?,
        productName: String?,
        content: String?,
        rating: Int?
    ) {
        guard let userId = userId,
                let productName = productName,
                let rating = rating,
              rating != 0
        else { return }
        
        let review = ReviewEntity(
            title: productName,
            content: content,
            rating: rating
        )
        
        interactor?.sendReview(id: userId, review: review)
    }
    
    func addFavorite(productId: Int) {
        interactor?.addFavorite(productId: productId)
    }
    
    func removeFavorite(productId: Int) {
        interactor?.removeFavorite(productId: productId)
    }
    
    // MARK: To Router
    func routeToMessage(chatId: String) {
        router?.routeToMessage(chatId: chatId)
    }
    
    func routeToMap(coordinates: [CoordinatesResult]) {
        guard let lat = Double(coordinates.first?.lat ?? "") else { return }
        guard let lon = Double(coordinates.first?.lon ?? "") else { return }
        
        let coord = CoordinareEntity(
            latitude: lat,
            longitude: lon
        )
        
        router?.routeToMap(coordinates: coord)
    }
    
    func goToDetail(id: Int) {
        router?.routeToDetail(id: id)
    }
    
    func goToFullscreen(
        images: [ProductResult.Image]?,
        selected: Int
    ) {
        guard let images = images?.map ({ $0.src! }) else { return }
        
        router?.routeToFullscreen(images: images, id: selected)
    }
    
    func goToProfile(id: Int) {
        router?.routeToProfile(id: id)
    }
    
    // MARK: To View
    func setProductInfo(data: ProductResult) {
        productEntity = data
        
        data.relatedIDS?.forEach({ id in
            interactor?.getSimilarProducts(productId: id)
        })
        
        if data.relatedIDS != nil, data.relatedIDS!.isEmpty {
            let isAuthorized = sessionProvider.isAuthorized
            interactor?.getFavoriteList(isAuthorized: isAuthorized)
        }
    }
    
    func setSimilarProducts(data: ProductResult) {
        productEntities.append(data)
        
        let isAuthorized = sessionProvider.isAuthorized
        interactor?.getFavoriteList(isAuthorized: isAuthorized)
    }
    
    func setStoreInfo(data: StoreInfoResult) {
        view?.setStoreInfo(data: data)
    }
    
    func setFavoriteList(data: [FavoriteResponse]) {
        let favoriteEntity = data.convertToEntities()
        
        productEntities.enumerated().forEach { index, product in
            if let favoriteEntity = favoriteEntity.first(where: { $0.id == product.id }) {
                productEntities[index].isFavorite = true
            }
        }
        
        if let favoriteEntity = favoriteEntity.first(where: { $0.id == productEntity?.id }) {
            productEntity?.isFavorite = true
        } else {
            productEntity?.isFavorite = false
        }
        
        view?.setSimilarProducts(data: productEntities)
        
        view?.setProductInfo(data: productEntity!)
    }
    
    func showSuccessReview() {
        view?.showSuccessReview()
    }
    
    func showReviewButton(data: CheckChatReviewResult) {
        view?.showReviewButton(data: data)
    }
    
    func setError(data: String) {
        view?.showError(data: data)
    }
    
    func setToastError(text: String, type: ToastErrorKind) {
        view?.showToastError(text: text, type: type)
    }
    
    func setMapError(text: String) {
        view?.showMapError(text: text)
    }
}
