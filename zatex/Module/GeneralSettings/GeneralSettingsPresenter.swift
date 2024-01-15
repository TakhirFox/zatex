//
//  GeneralSettingsGeneralSettingsPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

import UIKit

protocol GeneralSettingsPresenterProtocol: AnyObject {
    func getAdminAccess()
    
    func goToProfileEdit()
    func goToAdminPanel()
    func logout()
    func deleteAccount()
    
    func showSuccessDialog()
    func showAdminPanel()
    func setToastError(text: String)
}

class GeneralSettingsPresenter: BasePresenter {
    
    weak var view: GeneralSettingsViewControllerProtocol?
    var interactor: GeneralSettingsInteractorProtocol?
    var router: GeneralSettingsRouterProtocol?
    var logoutHandler: (() -> Void) = {}
    var sessionProvider: SessionProvider!
}

extension GeneralSettingsPresenter: GeneralSettingsPresenterProtocol {
    
    func getAdminAccess() {
        let session = sessionProvider.getSession()
        
        if session?.userId == "1" &&
            session?.userEmail == "winzero.nexis@mail.ru" {
            self.showAdminPanel()
        }
    }
    
    // MARK: To Router
    func goToProfileEdit() {
        router?.routeToProfileEdit()
    }
    
    func goToAdminPanel() {
        router?.routeToAdminPanel()
    }
    
    // MARK: To Interactor
    func logout() {
        self.sessionProvider.logout()
        UIApplication.shared.unregisterForRemoteNotifications()
        logoutHandler()
    }
    
    func deleteAccount() {
        let userEmail = sessionProvider.getSession()?.userEmail ?? "userEmail не найден"
        let username = sessionProvider.getSession()?.userNicename ?? "USERNAME не найден"
        let id = sessionProvider.getSession()?.userId ?? "id не найден"
        
        let data = DeleteAccountEmailRequest(
            to: "winzero.nexis@mail.ru",
            subject: "УДАЛЕНИЕ: Запрос на удаление аккаунта",
            message: "Удалить аккаунт по: \nuserEmail: \(userEmail) \nid: \(id) \nusername: \(username)"
        )
        
        interactor?.deleteAccount(data: data)
    }
    
    // MARK: To View
    func showSuccessDialog() {
        view?.showSuccess()
    }
    
    func showAdminPanel() {
        view?.showAdminPanel()
    }
    
    func setToastError(text: String) {
        view?.showToastError(text: text)
    }
}
