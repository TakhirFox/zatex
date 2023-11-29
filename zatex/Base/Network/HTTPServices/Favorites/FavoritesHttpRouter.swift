//
//  FavoritesHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.11.2023.
//

import Alamofire

enum FavoritesHttpRouter {
    case getFavoriteList(userId: Int)
    case addFavorite
    case removeFavorite
}

extension FavoritesHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case let .getFavoriteList(userId):
            return ""
            
        case .addFavorite:
            return ""
            
        case .removeFavorite:
            return ""
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getFavoriteList:
            return .get
            
        case .addFavorite,
                .removeFavorite:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getFavoriteList,
                .addFavorite,
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

