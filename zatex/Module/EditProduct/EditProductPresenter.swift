//
//  EditProductEditProductPresenter.swift
//  zatex
//
//  Created by winzero on 22/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//

import UIKit

protocol EditProductPresenterProtocol: AnyObject {

    func getProductInfo(id: Int)
    func getCategories()
    func getCurrencies()
    func uploadImage(image: UIImage)
    
    func checkTextFieldEmpty(
        productId: Int,
        data: ProductEntity
    )
    
    func updateProduct(
        productId: Int,
        data: ProductEntity
    )
    
    func removeImage(index: Int)
    
    
    func goToBack()
    
    
    func setProductInfo(data: ProductResult)
    func setCategories(data: [CategoryResult])
    func setCurrencies(data: [CurrencyResult])
    func setImage(image: MediaResult)
    func setSuccessUpload()
    func setProductError(text: String)
    func setToastCategoryError(text: String)
    func setToastCurrencyError(text: String)
    func setToastImageError(text: String)
    func setToastUpdateProductError(text: String)
}

class EditProductPresenter: BasePresenter {
    weak var view: EditProductViewControllerProtocol?
    var interactor: EditProductInteractorProtocol?
    var router: EditProductRouterProtocol?
    
    private var uploadedImages: [ProductResponse.Image] = []
}

extension EditProductPresenter: EditProductPresenterProtocol {
    
    // MARK: To Interactor
    func getProductInfo(id: Int) {
        interactor?.getProductInfo(id: id)
    }
    
    func getCategories() {
        interactor?.getCategories()
    }
    
    func getCurrencies() {
        interactor?.getCurrencies()
    }
    
    func uploadImage(image: UIImage) {
        interactor?.uploadImage(image: image)
    }
    
    func checkTextFieldEmpty(
        productId: Int,
        data: ProductEntity
    ) {
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
        
        if data.currencySymbol == nil  {
            view?.showEmptyCurrency()
        }
        
        if data.productName != nil,
           data.description != nil,
           data.cost != nil,
           data.category != nil,
           data.currencySymbol != nil 
        {
            updateProduct(
                productId: productId,
                data: data
            )
        }
    }
    
    func updateProduct(
        productId: Int,
        data: ProductEntity
    ) {
        let category = ProductResponse.Category(id: data.category)
        
        let currency = ProductResponse.ProductOptions(
            name: "Currency",
            options: [data.currencySymbol ?? ""],
            visible: true,
            variation: true
        )
        
        let product = ProductResponse(
            name: data.productName,
            description: data.description,
            regularPrice: data.cost,
            categories: [category],
            images: uploadedImages,
            attributes: [currency]
        )
        
        print("LOG: product \(product)")
        
        
//        interactor?.updateProduct(
//            id: productId,
//            data: product
//        )
    }
    
    func removeImage(index: Int) {
        uploadedImages.remove(at: index)
    }
    
    // MARK: To Router
    
    func goToBack() {
        router?.routeToBack()
    }
    
    // MARK: To View
    func setProductInfo(data: ProductResult) {
        let entity = ProductEntity(
            productName: data.name,
            category: data.categories?.first?.id,
            categoryName: data.categories?.first?.name,
            description: data.description,
            cost: data.regularPrice,
            currencySymbol: data.attributes.first(where: { $0.name == "Currency" })?.options.first,
            images: [],
            webImages: data.images?.compactMap({ $0.src }) ?? []
        )
            
        view?.setProductInfo(data: entity)
    }
    
    func setCategories(data: [CategoryResult]) {
        view?.setCategories(data: data)
    }
    
    func setCurrencies(data: [CurrencyResult]) {
        view?.setCurrencies(data: data)
    }
    
    func setImage(image: MediaResult) { // TODO: Change logic for upload images
        let urlImage = image.mediaDetails?.sizes?.woocommerceSingle?.sourceURL ?? ""
        let imageEntity = ProductResponse.Image(src: urlImage, position: uploadedImages.count)
        uploadedImages.insert(imageEntity, at: 0)
    }
    
    func setSuccessUpload() {
        view?.showSuccessUpload()
    }
    
    func setProductError(text: String) {
        view?.showProductError(text: text)
    }
    
    func setToastCategoryError(text: String) {
        view?.showToastCategoryError(text: text)
    }
    
    func setToastCurrencyError(text: String) {
        view?.showToastCurrencyError(text: text)
    }
    
    func setToastImageError(text: String) {
        view?.showToastImageError(text: text)
    }
    
    func setToastUpdateProductError(text: String) {
        view?.showToastUpdateProductError(text: text)
    }
}
