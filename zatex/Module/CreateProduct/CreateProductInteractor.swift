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
            self.presenter?.setCategories(data: result)
        }
    }
    
    func publishProduct(data: ProductResponse) {
        self.service.createProduct(product: data) {
            self.presenter?.showSuccess()
        }
    }
    
    func uploadImage(image: UIImage) {
        self.imageService.loadImage(image: image) { result in
            self.presenter?.setImage(image: result)
        }
    }
}
