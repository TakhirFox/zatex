//
//  ProductHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Alamofire

enum ProductHttpRouter {
    case getAllProducts(Int)
    case getCategories
    case getBanners
    case getProductsByCategory(String)
}

extension ProductHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://zakirovweb.online"
    }
    
    var path: String {
        switch self {
        case .getAllProducts:
            return "/wp-json/wc/v3/products"
        case .getCategories:
            return "/wp-json/wp/v2/product_cat"
        case .getBanners:
            return "/banner.json"
        case .getProductsByCategory:
            return "/wp-json/wc/v3/products"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAllProducts, .getCategories, .getBanners, .getProductsByCategory:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getAllProducts, .getCategories, .getBanners, .getProductsByCategory:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
        
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getAllProducts(let page):
            return [
                "page": "\(page)",
                "status": "publish",
                "consumer_key": "ck_354cbc09f836cf6ab10941f5437016b7252f13cb",
                "consumer_secret": "cs_188789d20497ddad20fe6598be304aa2efcaeec0"
            ]
        case .getCategories, .getBanners:
            return nil
        case .getProductsByCategory(let id):
            return [
                "category":"\(id)",
                "consumer_key": "ck_354cbc09f836cf6ab10941f5437016b7252f13cb",
                "consumer_secret": "cs_188789d20497ddad20fe6598be304aa2efcaeec0"
            ]
        }
        
    }
    
    func body() throws -> Data? {
        switch self {
        case .getCategories, .getAllProducts, .getBanners, .getProductsByCategory:
            return nil
        }
    }
    
    
}
