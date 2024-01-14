//
//  ProductHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Alamofire

enum ProductHttpRouter {
    case getAllProducts(Int, String)
    case getCategories
    case getProductsByCategory(String)
}

extension ProductHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .getAllProducts:
            return "/wp-json/wc/v3/products"
            
        case .getCategories:
            return "/wp-json/wp/v2/product_cat"
            
        case .getProductsByCategory:
            return "/wp-json/wc/v3/products"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAllProducts, .getCategories, .getProductsByCategory:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getAllProducts, .getCategories, .getProductsByCategory:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case let .getAllProducts(page, city):
            return [
                "page": "\(page)",
                "status": "publish",
                "consumer_key": "ck_354cbc09f836cf6ab10941f5437016b7252f13cb",
                "consumer_secret": "cs_188789d20497ddad20fe6598be304aa2efcaeec0",
                "city": city,
                "sold_individually": true
            ]
            
        case .getCategories:
            return [
                "per_page": 20
            ]
            
        case .getProductsByCategory(let id):
            return [
                "category":"\(id)",
                "consumer_key": "ck_354cbc09f836cf6ab10941f5437016b7252f13cb",
                "consumer_secret": "cs_188789d20497ddad20fe6598be304aa2efcaeec0",
                "sold_individually": true
            ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getCategories, .getAllProducts, .getProductsByCategory:
            return nil
        }
    }
}
