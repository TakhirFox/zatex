//
//  ReviewsHttpService.swift
//  zatex
//
//  Created by Zakirov Tahir on 20.03.2023.
//

import Alamofire

final class ReviewsHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
