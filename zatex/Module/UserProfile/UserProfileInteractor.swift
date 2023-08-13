//
//  UserProfileUserProfileInteractor.swift
//  zatex
//
//  Created by winzero on 13/08/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol UserProfileInteractorProtocol {
    func getStoreInfo(authorId: Int)
    func getStoreProduct(authorId: Int, isSales: Bool)
}

class UserProfileInteractor: BaseInteractor {
    weak var presenter: UserProfilePresenterProtocol?
    var service: ProfileAPI!
}

extension UserProfileInteractor: UserProfileInteractorProtocol {
    
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
    
    func getStoreProduct(authorId: Int, isSales: Bool) {
        self.service.fetchStoreProducts(authorId: authorId) { result in
            switch result {
            case let .success(data):
                self.presenter?.setStoreProduct(
                    data: data,
                    isSales: isSales
                )
                
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
