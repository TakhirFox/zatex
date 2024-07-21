//
//  EditProductHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.01.2024.
//

import Alamofire

enum EditProductHttpRouter {
    case getProductInfo(productId: Int)
    case updateProductInfo(productId: Int, entity: ProductResponse)
}

extension EditProductHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case let .getProductInfo(productId):
            return "/wp-json/wc/v3/products/\(productId)"
            
        case let .updateProductInfo(productId, _):
            return "/wp-json/wc/v3/products/\(productId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getProductInfo:
            return .get
            
        case .updateProductInfo:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getProductInfo,
                .updateProductInfo:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getProductInfo,
                .updateProductInfo:
            return nil
        }
    }
    
    var requestInterceptor: RequestInterceptor? {
        return AccessTokenInterceptor(userSettingsService: UserSettingsService.shared)
    }
    
    func body() throws -> Data? {
        switch self {
        case .getProductInfo:
            return nil
            
        case let .updateProductInfo(_, entity):
            return try JSONEncoder().encode(entity)
        }
    }
}
