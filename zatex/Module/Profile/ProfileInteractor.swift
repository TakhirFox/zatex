//
//  ProfileProfileInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol ProfileInteractorProtocol {
    func getStoreInfo(authorId: Int)
    func getStoreProduct(authorId: Int)
}

class ProfileInteractor: BaseInteractor {
    weak var presenter: ProfilePresenterProtocol?
    var service: ProfileAPI!
}

extension ProfileInteractor: ProfileInteractorProtocol {
    
    func getStoreInfo(authorId: Int) {
        self.service.fetchStoreInfo(authorId: authorId) { result in
            self.presenter?.setStoreInfo(data: result)
        }
    }
    
    func getStoreProduct(authorId: Int) {
        self.service.fetchStoreProducts(authorId: authorId) { result in
            self.presenter?.setStoreProduct(data: result)
        }
    }
}
