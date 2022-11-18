//
//  ProductHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Alamofire

enum ProductHttpRouter {
    case getProductsFromAllStore
    case getCategories
    case getBanners
}

extension ProductHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://zakirovweb.online"
    }
    
    var path: String {
        switch self {
        case .getProductsFromAllStore:
            return "/wp-json/wc/store/products"
        case .getCategories:
            return "/wp-json/wp/v2/product_cat"
        case .getBanners:
            return "/banner.json"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getProductsFromAllStore, .getCategories, .getBanners:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getProductsFromAllStore, .getCategories, .getBanners:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
        
    }
    
    var parameters: Alamofire.Parameters? {
        return nil
    }
    
    func body() throws -> Data? {
        switch self {
        case .getCategories, .getProductsFromAllStore, .getBanners:
            return nil
        }
    }
    
    
}
