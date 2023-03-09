//
//  AuthAuthPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 08/03/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol AuthPresenterProtocol: AnyObject {
    func checkTextFieldEmpty(login: String?, pass: String?)
    func authSuccess()
}

class AuthPresenter: BasePresenter {
    weak var view: AuthViewControllerProtocol?
    var interactor: AuthInteractorProtocol?
    var router: AuthRouterProtocol?
    
}

extension AuthPresenter: AuthPresenterProtocol {
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
    
    func authSuccess() {
        view?.updateView()
    }
}
