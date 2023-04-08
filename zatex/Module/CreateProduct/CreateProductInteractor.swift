//
//  CreateProductCreateProductInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol CreateProductInteractorProtocol {
    func getCategories()
    func publishProduct(data: ProductResponse)
}

class CreateProductInteractor: BaseInteractor {
    
    weak var presenter: CreateProductPresenterProtocol?
    var service: CreateProductAPI!
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
}
