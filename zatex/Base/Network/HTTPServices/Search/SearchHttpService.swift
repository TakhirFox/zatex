//
//  SearchHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.10.2022.
//

import Alamofire

final class SearchHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible, _ requestInterceptor: RequestInterceptor?) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
