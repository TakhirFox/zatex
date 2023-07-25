//
//  ResetPasswordResetPasswordInteractor.swift
//  zatex
//
//  Created by winzero on 30/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol ResetPasswordInteractorProtocol {
    
    func resetPassword(username: String)
}

class ResetPasswordInteractor: BaseInteractor {
    
    weak var presenter: ResetPasswordPresenterProtocol?
    var service: ResetPasswordAPI!
}

extension ResetPasswordInteractor: ResetPasswordInteractorProtocol {
    
    func resetPassword(username: String) {
        self.service.fetchResetPassword(
            username: username
        ) { result in
            switch result {
            case .success:
                self.presenter?.showSuccessDialog()
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setToastError(text: name)
                    
                case let .secondError(name):
                    self.presenter?.setToastError(text: name)
                }
            }
        }
    }
}
