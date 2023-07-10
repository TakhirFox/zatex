//
//  ProfileEditHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.07.2023.
//

import Alamofire

enum ProfileEditHttpRouter {
    case getStoreInfo(id: Int)
    case editStoreInfo(data: ProfileEditRequest)
}

extension ProfileEditHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://zakirovweb.online"
    }
    
    var path: String {
        switch self {
        case let .getStoreInfo(id):
            return "/wp-json/dokan/v1/stores/\(id)"
            
        case .editStoreInfo:
            return "/wp-json/dokan/v1/settings"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getStoreInfo:
            return .get
        case .editStoreInfo:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getStoreInfo,
                .editStoreInfo:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getStoreInfo,
                .editStoreInfo:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getStoreInfo:
            return nil
        case let .editStoreInfo(data):
            return try JSONEncoder().encode(data)
        }
    }
}