//
//  AuthAuthPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 08/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol AuthPresenterProtocol: AnyObject {
    
    func checkTextFieldEmpty(login: String?, pass: String?)
    
    func goToSignUp()
    func goToResetPassword()
    
    func authSuccess()
}

class AuthPresenter: BasePresenter {
    
    weak var view: AuthViewControllerProtocol?
    var interactor: AuthInteractorProtocol?
    var router: AuthRouterProtocol?
    var authorizationHandler: (() -> Void) = {}
}

extension AuthPresenter: AuthPresenterProtocol {
    
    // MARK: To Interactor
    func checkTextFieldEmpty(login: String?, pass: String?) {
        if let login = login, login == ""  {
//            view?.showLoginIsEmpty() // TODO: Допилить
        }
        
        if let pass = pass, pass == ""  {
//            view?.showPassIsEmpty() // TODO: Допилить
            
        }
        
        if let login = login, login != "", let pass = pass, pass != "" {
            authAndRoute(login: login, pass: pass)
        }
    }
    
    private func authAndRoute(login: String, pass: String) {
        interactor?.authAndRoute(login: login, pass: pass)
    }
    
    // MARK: To Router
    func goToSignUp() {
        router?.routeToSignUp()
    }
    
    func goToResetPassword() {
        router?.routeToResetPassword()
    }
    
    // MARK: To View
    func authSuccess() {
        authorizationHandler()
        view?.closeView()
    }
}
