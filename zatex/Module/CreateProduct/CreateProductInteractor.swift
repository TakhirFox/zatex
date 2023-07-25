//
//  CreateProductCreateProductInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol CreateProductInteractorProtocol {
    func getCategories()
    func publishProduct(data: ProductResponse)
    func uploadImage(image: UIImage)
}

class CreateProductInteractor: BaseInteractor {
    
    weak var presenter: CreateProductPresenterProtocol?
    var service: CreateProductAPI!
    var imageService: ImagesAPI!
}

extension CreateProductInteractor: CreateProductInteractorProtocol {
    
    func getCategories() {
        self.service.fetchCategories { result in
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
    
    func publishProduct(data: ProductResponse) {
        self.service.createProduct(product: data) { result in
            switch result {
            case let .success(data):
                self.presenter?.showSuccess(product: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastPublishError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastPublishError(text: name)
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
