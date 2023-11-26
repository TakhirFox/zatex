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
    case updateSalesProduct(productId: Int, isSales: Bool)
    case updateDeviceTokek(authorId: Int, deviceToken: String)
}

extension ProfileHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case let .getStoreInfo(authorId):
            return "/wp-json/dokan/v1/stores/\(authorId)"
            
        case let .getStoreProducts(authorId):
            return "/wp-json/dokan/v1/stores/\(authorId)/products"
            
        case let .updateSalesProduct(productId, _):
            return "/wp-json/wc/v3/products/\(productId)"
            
        case let .updateDeviceTokek(authorId, _):
            return "/wp-json/wp/v2/users/\(authorId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getStoreInfo,
                .getStoreProducts:
            return .get
            
        case .updateSalesProduct:
            return .put
            
        case .updateDeviceTokek:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getStoreInfo,
                .getStoreProducts:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
            
        case .updateSalesProduct,
                .updateDeviceTokek:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getStoreInfo,
                .getStoreProducts,
                .updateSalesProduct,
                .updateDeviceTokek:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getStoreInfo,
                .getStoreProducts:
            return nil
            
        case let.updateSalesProduct(_, isSales):
            let data = SetSalesProductRequest(isSales: isSales)
            return try JSONEncoder().encode(data)
            
        case let .updateDeviceTokek(_, deviceToken):
            let data = SetDeviceToken(deviceToken: deviceToken)
            return try JSONEncoder().encode(data)
        }
    }
}
