//
//  ProductDetailHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 12.03.2023.
//

import Alamofire

enum ProductDetailHttpRouter {
    case getProductInfo(productId: String)
    case getStoreInfo(authorId: Int)
    case checkChat(productAuthor: String,
                   productId: String)
}

extension ProductDetailHttpRouter: HttpRouter {
    
    private var token: String {
        return UserSettingsService.shared.token
    }
    
    var baseUrlString: String {
        return "https://zakirovweb.online"
    }
    
    var path: String {
        switch self {
        case let .getProductInfo(productId):
            return "/wp-json/wc/v3/products/\(productId)"
        case let .getStoreInfo(authorId):
            return "/wp-json/dokan/v1/stores/\(authorId)"
        case .checkChat:
            return "/wp-json/chats/v1/chats/check"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getProductInfo,
                .getStoreInfo:
            return .get
        case .checkChat:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getProductInfo,
                .getStoreInfo:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        case .checkChat:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getProductInfo:
            return [
                "consumer_key": "ck_354cbc09f836cf6ab10941f5437016b7252f13cb",
                "consumer_secret": "cs_188789d20497ddad20fe6598be304aa2efcaeec0"
            ]
        case .getStoreInfo:
            return nil
        case .checkChat:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getProductInfo,
                .getStoreInfo:
            return nil
        case let .checkChat(productAuthor, productId):
            let data = CheckChatResponse(
                authorId: productAuthor,
                productId: productId)
            
            return try JSONEncoder().encode(data)
        }
    }
}
