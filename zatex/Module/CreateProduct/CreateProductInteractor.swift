//
//  CreateProductCreateProductInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol CreateProductInteractorProtocol {
    
}

class CreateProductInteractor: BaseInteractor, CreateProductInteractorProtocol {
    weak var presenter: CreateProductPresenterProtocol?

}