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
    func saveAccess(token: String)
    func getSession() -> SessionData?
    func isMyAccount(id: Int) -> Bool
    func clearSession()
}

public final class UserSettingsService {
    private let emailValue: String = "email"
    private let tokenValue: String = "token"
    private let usernameValue: String = "username"
    private let userIdValue: String = "userId"
    private let refreshToken: String = "refresh_token"
    
    static let shared: UserSettingsService = UserSettingsService()
    
    private init() {}
}

extension UserSettingsService: UserSettingsAPI {
    
    public var token: String {
        return UserDefaults.standard.string(forKey: tokenValue) ?? ""
    }
    
    public func saveSession(session: SessionData) {
        UserDefaults.standard.set(session.user.data.userEmail, forKey: emailValue)
        UserDefaults.standard.set(session.user.data.userNicename, forKey: usernameValue)
        UserDefaults.standard.set(session.user.id, forKey: userIdValue)
        UserDefaults.standard.set(session.accessToken, forKey: tokenValue)
        UserDefaults.standard.set(session.refreshToken, forKey: refreshToken)
    }
    
    public func saveAccess(token: String) {
        UserDefaults.standard.set(token, forKey: tokenValue)
    }
    
    public func getSession() -> SessionData? {
//        UserDefaults.standard.set("session.accessToken", forKey: tokenValue)
//        UserDefaults.standard.set("session.accessToken", forKey: refreshToken)
        let userId = UserDefaults.standard.integer(forKey: userIdValue)
        let email = UserDefaults.standard.string(forKey: emailValue)
        let token = UserDefaults.standard.string(forKey: tokenValue)
        let username = UserDefaults.standard.string(forKey: usernameValue)
        let refreshToken = UserDefaults.standard.string(forKey: refreshToken)
        
        return SessionData(
            user: SessionData.User(
                data: AuthResult.Data(
                    userLogin: username ?? "",
                    userNicename: "",
                    userEmail: email ?? "",
                    userRegistered: "",
                    displayName: ""
                ),
                id: userId
            ),
            accessToken: token,
            expiresIn: 0,
            refreshToken: refreshToken ?? ""
        )
    }
    
    public func isMyAccount(id: Int) -> Bool {
        return getSession()?.user.id == id
    }
    
    public func clearSession() {
        UserDefaults.standard.removeObject(forKey: userIdValue)
        UserDefaults.standard.removeObject(forKey: emailValue)
        UserDefaults.standard.removeObject(forKey: tokenValue)
        UserDefaults.standard.removeObject(forKey: usernameValue)
        UserDefaults.standard.removeObject(forKey: refreshToken)
    }
}
