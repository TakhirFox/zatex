//
//  CreateProductCreateProductPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol CreateProductPresenterProtocol: AnyObject {
    func getCategories()
    func publishProduct(data: ProductEntity)
    
    func setCategories(data: [CategoryResult])
    func showSuccess()
}

class CreateProductPresenter: BasePresenter {
    weak var view: CreateProductViewControllerProtocol?
    var interactor: CreateProductInteractorProtocol?
    var router: CreateProductRouterProtocol?
    
}

extension CreateProductPresenter: CreateProductPresenterProtocol {
    
    // MARK: To Interactor
    func getCategories() {
        interactor?.getCategories()
    }
    
    func publishProduct(data: ProductEntity) {
        
        let category = ProductResponse.Category(id: data.category)
        var image: [ProductResponse.Image] = []
        
//        for img in data.images.count { // TODO: Понадобится при загрузке фоток
//            image = img
//        }
        
        let product = ProductResponse(
            name: data.productName,
            description: data.description,
            regularPrice: data.cost,
            categories: [category],
            images: image
        )
        
        
        interactor?.publishProduct(data: product)
    }
    
    // MARK: To Router
    
    // MARK: To View
    func setCategories(data: [CategoryResult]) {
        view?.setCategories(data: data)
    }
    
    func showSuccess() {
        view?.showSuccess()
    }
}
