//
//  AdminPanelAdminPanelInteractor.swift
//  zatex
//
//  Created by winzero on 14/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//


protocol AdminPanelInteractorProtocol {
    
    func getUserList(page: Int)
}

class AdminPanelInteractor: BaseInteractor {
    
    weak var presenter: AdminPanelPresenterProtocol?
    var service: AdminPanelAPI!
}

extension AdminPanelInteractor: AdminPanelInteractorProtocol {
    
    func getUserList(page: Int) {
        self.service.fetchUserList(page: page) { result in
            switch result {
            case let .success(data):
                self.presenter?.setUserList(data: data)
                
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
