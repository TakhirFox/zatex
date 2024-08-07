//
//  ProductHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Alamofire

final class ProductHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible, _ requestInterceptor: RequestInterceptor?) -> DataRequest {
        return sessionManager.request(urlRequest, interceptor: requestInterceptor).validate(statusCode: 200..<400)
    }
}
