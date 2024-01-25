//
//  EditProductEditProductInteractor.swift
//  zatex
//
//  Created by winzero on 22/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//

import UIKit

protocol EditProductInteractorProtocol {
    func getProductInfo(id: Int)
    func getCategories()
    func getCurrencies()
    
    func updateProduct(
        id: Int,
        data: ProductResponse
    )
    
    func uploadImage(image: UIImage)
}

class EditProductInteractor: BaseInteractor {
    weak var presenter: EditProductPresenterProtocol?
    var service: EditProductAPI!
    var imageService: ImagesAPI!
    var createProductService: CreateProductAPI!
}

extension EditProductInteractor: EditProductInteractorProtocol {
    
    func getProductInfo(id: Int) {
        self.service.fetchProductInfo(id: id) { result in
            switch result {
            case let .success(data):
                self.presenter?.setProductInfo(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setProductError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setProductError(text: name)
                }
            }
        }
    }
    
    func getCategories() {
        self.createProductService.fetchCategories { result in
            switch result {
            case let .success(data):
                self.presenter?.setCategories(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastCategoryError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastCategoryError(text: name)
                }
            }
        }
    }
    
    func getCurrencies() {
        self.createProductService.fetchCurrencies { result in
            switch result {
            case let .success(data):
                self.presenter?.setCurrencies(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastCurrencyError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastCurrencyError(text: name)
                }
            }
        }
    }
    
    func updateProduct(
        id: Int,
        data: ProductResponse
    ) {
        self.service.updateProductInfo(
            id: id,
            product: data
        ){ result in
            switch result {
            case .success:
                self.presenter?.setSuccessUpload()
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastUpdateProductError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastUpdateProductError(text: name)
                }
            }
        }
    }
    
    func uploadImage(image: UIImage) {
        self.imageService.loadImage(image: image) { result in
            switch result {
            case let .success(data):
                self.presenter?.setImage(image: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastImageError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastImageError(text: name)
                }
            }
        }
    }
}
