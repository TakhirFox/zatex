//
//  ProductDetailHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 12.03.2023.
//

import Alamofire

enum ProductDetailHttpRouter {
    case getProductInfo(productId: Int)
    case getStoreInfo(authorId: Int)
    
    case checkChat(
        productAuthor: Int,
        productId: Int
    )
    
    case checkChatToReview(
        productAuthor: Int,
        productId: Int
    )
    
    case sendReview(id: Int, review: ReviewEntity)
}

extension ProductDetailHttpRouter: HttpRouter {
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
            
        case .checkChatToReview:
            return "/wp-json/chats/v1/chats/checkToReview"
            
        case let .sendReview(id, _):
            return "/wp-json/dokan/v1/stores/\(id)/reviews"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getProductInfo,
                .getStoreInfo,
                .checkChatToReview:
            return .get
            
        case .checkChat,
                .sendReview:
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
            
        case .checkChat,
                .checkChatToReview,
                .sendReview:
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
            
        case let .checkChatToReview(productId, productAuthor):
            return [
                "user2_id": productAuthor,
                "product_id": productId
            ]
            
        case .sendReview:
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
            
        case .checkChatToReview:
            return nil
            
        case let .sendReview(_, review):
            return try JSONEncoder().encode(review)
        }
    }
}
