//
//  CreateProductHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 06.04.2023.
//

import Alamofire

enum CreateProductHttpRouter {
    case getCategories
    case getCurrencies
    case createProduct(product: ProductResponse)
}

extension CreateProductHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .getCategories:
            return "/wp-json/wp/v2/product_cat"
            
        case .getCurrencies:
            return "/wp-json/currency/v1/list"
            
        case .createProduct:
            return "/wp-json/dokan/v1/products"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getCategories,
                .getCurrencies:
            return .get
            
        case .createProduct:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getCategories,
                .getCurrencies:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
            
        case .createProduct:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getCategories:
            return [
                "per_page": 20
            ]
            
        case .getCurrencies,
                .createProduct:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getCategories,
                .getCurrencies:
            return nil
            
        case let .createProduct(product):
            return try JSONEncoder().encode(product)
        }
    }
}
