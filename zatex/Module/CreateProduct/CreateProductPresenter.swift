//
//  CreateProductCreateProductPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol CreateProductPresenterProtocol: AnyObject {

}

class CreateProductPresenter: BasePresenter {
    weak var view: CreateProductViewControllerProtocol?
    var interactor: CreateProductInteractorProtocol?
    var router: CreateProductRouterProtocol?
    
}

extension CreateProductPresenter: CreateProductPresenterProtocol {
    
}
