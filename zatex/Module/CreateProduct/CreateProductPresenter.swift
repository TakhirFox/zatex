//
//  CreateProductCreateProductPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol CreateProductPresenterProtocol: AnyObject {
    func getCategories()
    func uploadImage(image: UIImage)
    func checkTextFieldEmpty(data: ProductEntity)
    func publishProduct(data: ProductEntity)
    func removeImage(index: Int)
    
    func goToDetail(id: Int)
    
    func setCategories(data: [CategoryResult])
    func setImage(image: MediaResult)
    func showSuccess(product: ProductResult)
    func setToastCategoryError(text: String)
    func setToastPublishError(text: String)
    func setToastImageError(text: String)
}

class CreateProductPresenter: BasePresenter {
    weak var view: CreateProductViewControllerProtocol?
    var interactor: CreateProductInteractorProtocol?
    var router: CreateProductRouterProtocol?
    
    private var uploadedImages: [ProductResponse.Image] = []
}

extension CreateProductPresenter: CreateProductPresenterProtocol {
    
    // MARK: To Interactor
    func getCategories() {
        interactor?.getCategories()
    }
    
    func uploadImage(image: UIImage) {
        interactor?.uploadImage(image: image)
    }
    
    func checkTextFieldEmpty(data: ProductEntity) {
        if data.productName == nil  {
            view?.showEmptyProductName()
        }
        
        if data.description == nil  {
            view?.showEmptyDescription()
        }
        
        if data.cost == nil  {
            view?.showEmptyCost()
        }
        
        if data.category == nil  {
            view?.showEmptyCategory()
        }
        
        if data.productName != nil,
           data.description != nil,
           data.cost != nil,
           data.category != nil {
            publishProduct(data: data)
        }
    }
    
    func publishProduct(data: ProductEntity) {
        let category = ProductResponse.Category(id: data.category)
        
        let product = ProductResponse(
            name: data.productName,
            description: data.description,
            regularPrice: data.cost,
            categories: [category],
            images: uploadedImages
        )
        
        interactor?.publishProduct(data: product)
    }
    
    func removeImage(index: Int) {
        uploadedImages.remove(at: index)
    }
    
    // MARK: To Router
    
    func goToDetail(id: Int) {
        router?.routeToDetail(id: id)
    }
    
    // MARK: To View
    func setCategories(data: [CategoryResult]) {
        view?.setCategories(data: data)
    }
    
    func setImage(image: MediaResult) {
        let urlImage = image.mediaDetails?.sizes?.woocommerceSingle?.sourceURL ?? ""
        let imageEntity = ProductResponse.Image(src: urlImage, position: uploadedImages.count)
        uploadedImages.insert(imageEntity, at: 0)
        
        view?.stopImageSpinner()
    }
    
    func showSuccess(product: ProductResult) {
        view?.showSuccess(product: product)
    }
    
    func setToastCategoryError(text: String) {
        view?.showToastCategoryError(text: text)
    }
    
    func setToastPublishError(text: String) {
        view?.showToastPublishError(text: text)
    }
    
    func setToastImageError(text: String) {
        view?.showToastImageError(text: text)
    }
}
