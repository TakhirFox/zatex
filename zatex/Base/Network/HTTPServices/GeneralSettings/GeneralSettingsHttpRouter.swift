//
//  GeneralSettingsHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.11.2023.
//

import Alamofire

enum GeneralSettingsHttpRouter {
    case sendRequestDeleteAccount(data: DeleteAccountEmailRequest)
}

extension GeneralSettingsHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .sendRequestDeleteAccount:
            return "/wp-json/email/v1/send_email"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .sendRequestDeleteAccount:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .sendRequestDeleteAccount:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .sendRequestDeleteAccount:
            return nil
        }
    }
    
    var requestInterceptor: RequestInterceptor? {
        return AccessTokenInterceptor(userSettingsService: UserSettingsService.shared)
    }
    
    func body() throws -> Data? {
        switch self {
        case let .sendRequestDeleteAccount(data):
            return try JSONEncoder().encode(data)
        }
    }
}
