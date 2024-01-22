//
//  SessionProvider.swift
//  zatex
//
//  Created by Zakirov Tahir on 25.05.2023.
//

import Foundation

protocol SessionProvider {
    
    var isAuthorized: Bool { get }
    
    func getSession() -> SessionData?
    func setSession(_ session: SessionData)
    func isMyAccount(id: Int) -> Bool
    func logout()
}

final class AppSessionProvider: SessionProvider {
    
    private let userSettingsService = UserSettingsService.shared
    
    var isAuthorized: Bool {
        userSettingsService.getSession()?.token != nil
    }
    
    func getSession() -> SessionData? {
        userSettingsService.getSession()
    }
    
    func setSession(_ session: SessionData) {
        userSettingsService.saveSession(session: session)
    }
    
    func isMyAccount(id: Int) -> Bool {
        userSettingsService.isMyAccount(id: id)
    }
    
    func logout() {
        userSettingsService.clearSession()
    }
}
