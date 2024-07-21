//
//  AdditionalInfoHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.07.2023.
//

import Alamofire

enum AdditionalInfoHttpRouter {
    case additionalInfo(data: AdditionalInfoRequest)
}

extension AdditionalInfoHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .additionalInfo:
            return "/wp-json/dokan/v1/settings"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .additionalInfo:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .additionalInfo:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .additionalInfo:
            return nil
        }
    }
    
    var requestInterceptor: RequestInterceptor? {
        return AccessTokenInterceptor(userSettingsService: UserSettingsService.shared)
    }
    
    func body() throws -> Data? {
        switch self {
        case let .additionalInfo(data):
            return try JSONEncoder().encode(data)
        }
    }
}
