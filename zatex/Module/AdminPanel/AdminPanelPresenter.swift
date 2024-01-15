//
//  AdminPanelAdminPanelPresenter.swift
//  zatex
//
//  Created by winzero on 14/01/2024.
//  Copyright © 2024 zakirovweb. All rights reserved.
//

protocol AdminPanelPresenterProtocol: AnyObject {
    
    func getUserList(page: Int)
    
    func getMainData()
    
    func goToUserList()
    func goToStats()
    
    func setUserList(data: [UserResponse])
    func setError(data: String)
}

class AdminPanelPresenter: BasePresenter {
    
    enum AdminPanelType {
        case main
        case userList
        case stats
        case userDetail
    }
    
    weak var view: AdminPanelViewControllerProtocol?
    var interactor: AdminPanelInteractorProtocol?
    var router: AdminPanelRouterProtocol?
}

extension AdminPanelPresenter: AdminPanelPresenterProtocol {
    
    // MARK: To Interactor
    func getUserList(page: Int) {
        interactor?.getUserList(page: page)
    }
    
    // MARK: To Router
    func goToUserList() {
        router?.routeToNext(type: .userList)
    }
    
    func goToStats() {
        router?.routeToNext(type: .stats)
    }
    
    // MARK: To View
    func getMainData() {
        view?.setMainEntity()
    }
    
    func setUserList(data: [UserResponse]) {
        let entity = data.map { user in
            let firstName = user.firstName
            let lastName = user.lastName
            let storeName = user.storeName
            var image = ""
            
            if let gravatar = user.gravatar {
                switch gravatar {
                case .avatar(let avatar):
                    image = avatar
                    
                default:
                    break
                }
            }
            
            return AdminPanelEntry(
                id: user.id,
                title: "\(firstName) \(lastName) (\(storeName))",
                subTitle: "Зареган: \(user.registered)",
                imageUrl: image,
                type: .userDetail
            )
        }
        
        view?.showUserList(data: entity)
    }
    
    func setError(data: String) {
        // TODO: 
    }
}


extension AdminPanelPresenter.AdminPanelType {
    var title: String {
        switch self {
        case .main:
            "Админ панель"
            
        case .userList:
            "Пользователи"
            
        case .stats:
            "Статистика"
            
        case .userDetail:
            "Детали пользователя"
        }
    }
}

