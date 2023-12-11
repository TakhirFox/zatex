//
//  FavoritesHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.11.2023.
//

import Alamofire

enum FavoritesHttpRouter {
    case getFavoriteList(isAuthorized: Bool)
    case addFavorite(productId: Int)
    case removeFavorite(productId: Int)
}

extension FavoritesHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .getFavoriteList:
            return "/wp-json/favorite/v1/favorite"
            
        case let .addFavorite(userId):
            return "/wp-json/favorite/v1/add/\(userId)"
            
        case let .removeFavorite(userId):
            return "/wp-json/favorite/v1/remove/\(userId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getFavoriteList:
            return .get
            
        case .addFavorite:
            return .post
            
        case .removeFavorite:
            return .delete
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case let .getFavoriteList(isAuthorized):
            return isAuthorized
            ? ["Authorization": "Bearer \(token)"]
            : nil
            
        case .addFavorite,
                .removeFavorite:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getFavoriteList,
                .addFavorite,
                .removeFavorite:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getFavoriteList,
                .addFavorite,
                .removeFavorite:
            return nil
        }
    }
}

