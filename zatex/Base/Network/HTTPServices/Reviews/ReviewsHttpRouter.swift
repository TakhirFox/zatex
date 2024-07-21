//
//  ReviewsHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 20.03.2023.
//

import Alamofire

enum ReviewsHttpRouter {
    case getReviewsList(authorId: String)
    case getStoreInfo(authorId: String)
}

extension ReviewsHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case let .getReviewsList(authorId):
            return "/wp-json/dokan/v1/stores/\(authorId)/reviews"
        case let .getStoreInfo(authorId):
            return "/wp-json/dokan/v1/stores/\(authorId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getReviewsList,
                .getStoreInfo:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getReviewsList,
                .getStoreInfo:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getReviewsList,
                .getStoreInfo:
            return nil
        }
    }
    
    var requestInterceptor: RequestInterceptor? {
        return AccessTokenInterceptor(userSettingsService: UserSettingsService.shared)
    }
    
    func body() throws -> Data? {
        switch self {
        case .getReviewsList,
                .getStoreInfo:
            return nil
        }
    }
}
