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
            switch result {
            case let .success(data):
                self.presenter?.setStoreInfo(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setError(data: name)
                    
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
    
    func getStoreProduct(authorId: Int) {
        self.service.fetchStoreProducts(authorId: authorId) { result in
            switch result {
            case let .success(data):
                self.presenter?.setStoreProduct(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setError(data: name)
                    
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
}
