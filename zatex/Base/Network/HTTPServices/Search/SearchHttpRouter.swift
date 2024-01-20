//
//  SearchHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.10.2022.
//

import Alamofire

enum SearchHttpRouter {
    case getSearchResult(String)
}

extension SearchHttpRouter: HttpRouter {
    
    var path: String {
        switch self {
        case .getSearchResult:
            return "/wp-json/wc/v2/products"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getSearchResult:
            return .get
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .getSearchResult:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
        
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getSearchResult(let search):
            return [
                "search":"\(search)",
                "consumer_key": "ck_354cbc09f836cf6ab10941f5437016b7252f13cb",
                "consumer_secret": "cs_188789d20497ddad20fe6598be304aa2efcaeec0",
                "status": "publish"
            ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getSearchResult:
            return nil
        }
    }
    
    
}
