//
//  GeneralSettingsHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.11.2023.
//

import Alamofire

final class GeneralSettingsHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible, _ requestInterceptor: RequestInterceptor?) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
