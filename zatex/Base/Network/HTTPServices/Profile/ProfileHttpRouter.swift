//
//  ProfileHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 18.03.2023.
//

import Alamofire

enum ProfileHttpRouter {
    case getStoreInfo(authorId: Int)
    case getStoreProducts(authorId: Int, currentPage: Int, saleStatus: String)
    case getStoreStatsProducts(authorId: Int)
    case updateSalesProduct(productId: Int, saleStatus: String)
    case updateDeviceTokek(authorId: Int, deviceToken: String)
}

extension ProfileHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case let .getStoreInfo(authorId):
            return "/wp-json/dokan/v1/stores/\(authorId)"
            
        case let .getStoreProducts(authorId, _, _),
            let .getStoreStatsProducts(authorId):
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
                .getStoreProducts,
                .getStoreStatsProducts:
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
                .getStoreProducts,
                .getStoreStatsProducts:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
            
        case .updateSalesProduct,
                .updateDeviceTokek:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case let .getStoreProducts(_ , currentPage, saleStatus):
            return [
                "page": currentPage,
                "per_page": 10,
                "status": saleStatus
            ]
            
        case .getStoreStatsProducts:
            return [
                "per_page": 100
            ]
            
        case .getStoreInfo,
                .updateSalesProduct,
                .updateDeviceTokek:
            return nil
        }
    }
    
    var requestInterceptor: RequestInterceptor? {
        return AccessTokenInterceptor(userSettingsService: UserSettingsService.shared)
    }
    
    func body() throws -> Data? {
        switch self {
        case .getStoreInfo,
                .getStoreProducts,
                .getStoreStatsProducts:
            return nil
            
        case let .updateSalesProduct(_, saleStatus):
            let data = SetSalesProductRequest(saleStatus: saleStatus)
            return try JSONEncoder().encode(data)
            
        case let .updateDeviceTokek(_, deviceToken):
            let data = SetDeviceToken(deviceToken: deviceToken)
            return try JSONEncoder().encode(data)
        }
    }
}
