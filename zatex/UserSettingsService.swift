//
//  UserSettingsService.swift
//  zatex
//
//  Created by Zakirov Tahir on 09.03.2023.
//

import Foundation

public typealias TokenData = AuthResult

public protocol UserSettingsAPI {
    var token: String { get }
    func saveTokens(tokenData: TokenData)
    func getTokens() -> TokenData
    func clearTokens()
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
    
    public func saveTokens(tokenData: TokenData) {
        UserDefaults.standard.set(tokenData.userEmail, forKey: emailValue)
        UserDefaults.standard.set(tokenData.token, forKey: tokenValue)
        UserDefaults.standard.set(tokenData.userNicename, forKey: usernameValue)
        UserDefaults.standard.set(tokenData.userId, forKey: userIdValue)
    }
    
    public func getTokens() -> TokenData {
        let userId = UserDefaults.standard.string(forKey: userIdValue) ?? ""
        let email = UserDefaults.standard.string(forKey: emailValue) ?? ""
        let token = UserDefaults.standard.string(forKey: tokenValue) ?? ""
        let username = UserDefaults.standard.string(forKey: usernameValue) ?? ""
        
        return TokenData(userId: userId,
                         token: token,
                         userEmail: email,
                         userNicename: "",
                         userDisplayName: username)
    }
    
    public func clearTokens() {
        UserDefaults.standard.removeObject(forKey: userIdValue)
        UserDefaults.standard.removeObject(forKey: emailValue)
        UserDefaults.standard.removeObject(forKey: tokenValue)
        UserDefaults.standard.removeObject(forKey: usernameValue)
    }
}
