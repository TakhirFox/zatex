//
//  ProfileProfileInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 17/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol ProfileInteractorProtocol {
    func getStoreInfo(authorId: Int)
    
    func getStoreProduct(
        authorId: Int,
        isSales: Bool
    )
    
    func setSalesProfuct(
        productId: Int,
        isSales: Bool,
        authorId: Int
    )
    
    func saveDeviceToken(
        authorId: Int,
        deviceToken: String
    )
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
    
    func getStoreProduct(authorId: Int, isSales: Bool) {
        self.service.fetchStoreProducts(authorId: authorId) { result in
            switch result {
            case let .success(data):
                self.presenter?.setStoreProduct(
                    data: data,
                    isSales: isSales
                )
                
                self.presenter?.setProductStats(data: data)
                
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
    
    func setSalesProfuct(
        productId: Int,
        isSales: Bool,
        authorId: Int
    ) {
        self.service.setSalesProfuct(
            productId: productId,
            isSales: isSales
        ) { result in
            switch result {
            case .success:
                self.getStoreProduct(authorId: authorId, isSales: false)
                
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
    
    func saveDeviceToken(
        authorId: Int,
        deviceToken: String
    ) {
        self.service.saveDeviceToken(
            authorId: authorId,
            deviceToken: deviceToken
        ) { result in
            switch result {
            case .success:
                debugPrint("LOG: device token successfully saved")
                
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
