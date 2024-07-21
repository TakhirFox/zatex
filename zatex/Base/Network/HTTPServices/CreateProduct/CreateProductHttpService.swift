//
//  CreateProductHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 06.04.2023.
//

import Alamofire

final class CreateProductHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible, _ requestInterceptor: RequestInterceptor?) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
