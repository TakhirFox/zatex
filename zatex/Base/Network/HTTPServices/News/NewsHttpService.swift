//
//  NewsHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 29.11.2023.
//

import Alamofire

final class NewsHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
