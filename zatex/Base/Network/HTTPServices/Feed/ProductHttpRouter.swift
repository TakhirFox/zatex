//
//  ProductHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Alamofire

enum ProductHttpRouter {
    case getAllProducts(categoryId: Int?, page: Int, city: String)
    case getCategories
}

extension ProductHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .getAllProducts:
            return "/wp-json/wc/v3/products"
            
        case .getCategories:
            return "/wp-json/wp/v2/product_cat"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAllProducts, .getCategories:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getAllProducts, .getCategories:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case let .getAllProducts(categoryId, page, city):
            var params: [String : Any] = [:]
            
            params = [
                "page": page,
                "city": city,
                "consumer_key": "ck_354cbc09f836cf6ab10941f5437016b7252f13cb",
                "consumer_secret": "cs_188789d20497ddad20fe6598be304aa2efcaeec0",
                "status": "publish"
            ]
            
            if categoryId != nil {
                params["category"] = categoryId!
            }
            
            return params
            
        case .getCategories:
            return [
                "per_page": 20
            ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getCategories, .getAllProducts:
            return nil
        }
    }
}
