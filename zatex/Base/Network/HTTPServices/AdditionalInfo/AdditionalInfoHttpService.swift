//
//  AdditionalInfoHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.07.2023.
//

import Alamofire

final class AdditionalInfoHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
