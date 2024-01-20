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
        currentPage: Int,
        saleStatus: String
    )
    
    func getStoreStatsProduct(
        authorId: Int
    )
    
    func setSalesProfuct(
        productId: Int,
        saleStatus: String,
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
    
    func getStoreProduct(
        authorId: Int,
        currentPage: Int,
        saleStatus: String
    ) {
        self.service.fetchStoreProducts(
            authorId: authorId,
            currentPage: currentPage,
            saleStatus: saleStatus
        ) { result in
            switch result {
            case let .success(data):
                self.presenter?.setStoreProduct(
                    data: data
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
    
    func getStoreStatsProduct(
        authorId: Int
    ) {
        self.service.fetchStoreStatsProducts(
            authorId: authorId
        ) { result in
            switch result {
            case let .success(data):
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
        saleStatus: String,
        authorId: Int
    ) {
        self.service.setSalesProfuct(
            productId: productId,
            saleStatus: saleStatus
        ) { result in
            switch result {
            case .success:
                break
                
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
