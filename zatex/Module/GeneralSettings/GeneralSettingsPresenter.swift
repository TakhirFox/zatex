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
        
        if session?.user.id == 1 &&
            session?.user.data.userEmail == "winzero.nexis@mail.ru" {
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
        let userEmail = sessionProvider.getSession()?.user.data.userEmail ?? "userEmail не найден"
        let username = sessionProvider.getSession()?.user.data.userNicename ?? "USERNAME не найден"
        let id = sessionProvider.getSession()?.user.id ?? 0
        
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
