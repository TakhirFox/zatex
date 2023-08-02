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
    func setToastError(text: String)
}

class AuthPresenter: BasePresenter {
    
    enum Signal {
        case successAuth
        case successSignUp
    }
    
    weak var view: AuthViewControllerProtocol?
    var interactor: AuthInteractorProtocol?
    var router: AuthRouterProtocol?
    var onSignal: (Signal) -> Void = { _ in }
}

extension AuthPresenter: AuthPresenterProtocol {
    
    // MARK: To Interactor
    func checkTextFieldEmpty(login: String?, pass: String?) {
        if let login = login, login == ""  {
            view?.showEmptyLogin()
        }
        
        if let pass = pass, pass == ""  {
            view?.showEmptyPassword()
            
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
        router?.routeToSignUp { [weak self] in
            self?.onSignal(.successSignUp)
            self?.view?.closeView()
        }
    }
    
    func goToResetPassword() {
        router?.routeToResetPassword()
    }
    
    // MARK: To View
    func authSuccess() {
        onSignal(.successAuth)
        view?.closeView()
    }
    
    func setToastError(text: String) {
        view?.showToastError(text: text)
    }
}
