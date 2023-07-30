//
//  ProfileHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 18.03.2023.
//

import Alamofire

enum ProfileHttpRouter {
    case getStoreInfo(authorId: Int)
    case getStoreProducts(authorId: Int)
}

extension ProfileHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://zakirovweb.online"
    }
    
    var path: String {
        switch self {
        case let .getStoreInfo(authorId):
            return "/wp-json/dokan/v1/stores/\(authorId)"
        case let .getStoreProducts(authorId):
            return "/wp-json/dokan/v1/stores/\(authorId)/products"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getStoreInfo,
                .getStoreProducts:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getStoreInfo,
                .getStoreProducts:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getStoreInfo,
                .getStoreProducts:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getStoreInfo,
                .getStoreProducts:
            return nil
        }
    }
}
