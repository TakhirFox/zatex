//
//  UserSettingsService.swift
//  zatex
//
//  Created by Zakirov Tahir on 09.03.2023.
//

import Foundation

public typealias SessionData = AuthResult // TODO: Change to SessionModel

public protocol UserSettingsAPI {
    var token: String { get }
    func saveSession(session: SessionData)
    func getSession() -> SessionData?
    func clearSession()
}

public final class UserSettingsService {
    private let emailValue: String = "email"
    private let tokenValue: String = "token"
    private let usernameValue: String = "username"
    private let userIdValue: String = "userId"
    
    static let shared: UserSettingsService = UserSettingsService()
    
    private init() {}
}

extension UserSettingsService: UserSettingsAPI {
    
    public var token: String {
        return UserDefaults.standard.string(forKey: tokenValue) ?? ""
    }
    
    public func saveSession(session: SessionData) {
        UserDefaults.standard.set(session.userEmail, forKey: emailValue)
        UserDefaults.standard.set(session.token, forKey: tokenValue)
        UserDefaults.standard.set(session.userNicename, forKey: usernameValue)
        UserDefaults.standard.set(session.userId, forKey: userIdValue)
    }
    
    public func getSession() -> SessionData? {
        let userId = UserDefaults.standard.string(forKey: userIdValue)
        let email = UserDefaults.standard.string(forKey: emailValue)
        let token = UserDefaults.standard.string(forKey: tokenValue)
        let username = UserDefaults.standard.string(forKey: usernameValue)
        
        return SessionData(userId: userId,
                           token: token,
                           userEmail: email,
                           userNicename: "",
                           userDisplayName: username)
    }
    
    public func clearSession() {
        UserDefaults.standard.removeObject(forKey: userIdValue)
        UserDefaults.standard.removeObject(forKey: emailValue)
        UserDefaults.standard.removeObject(forKey: tokenValue)
        UserDefaults.standard.removeObject(forKey: usernameValue)
    }
}
