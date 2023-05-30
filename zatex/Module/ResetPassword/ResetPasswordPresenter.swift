//
//  ResetPasswordResetPasswordPresenter.swift
//  zatex
//
//  Created by winzero on 30/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol ResetPasswordPresenterProtocol: AnyObject {

    func checkTextFieldEmpty(
        username: String?
    )
    
    func showSuccessDialog()
}

class ResetPasswordPresenter: BasePresenter {
    
    weak var view: ResetPasswordViewControllerProtocol?
    var interactor: ResetPasswordInteractorProtocol?
    var router: ResetPasswordRouterProtocol?
}

extension ResetPasswordPresenter: ResetPasswordPresenterProtocol {
    
    // MARK: To Interactor
    func checkTextFieldEmpty(
        username: String?
    ) {
        if let username = username, username == ""  {
            //            view?.showLoginIsEmpty() // TODO: Допилить
        }
        
        if let username = username, username != "" {
            resetPassword(
                username: username
            )
        }
    }
    
    private func resetPassword(username: String) {
        interactor?.resetPassword(
            username: username
        )
    }
    
    // MARK: To Router
    
    // MARK: To View
    func showSuccessDialog() {
        view?.showSuccess()
    }
}
