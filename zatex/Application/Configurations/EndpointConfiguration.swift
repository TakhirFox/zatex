//
//  EndpointConfiguration.swift
//  zatex
//
//  Created by Zakirov Tahir on 24.06.2024.
//

import Foundation

struct EndpointConfiguration {
    
    private struct URLs {
        static let testBaseUrl = "https://test01.zatex.ru"
        static let productionBaseUrl = "https://zatex.ru"
    }
    
    static var baseUrl: String {
        switch StandConfiguration.current {
        case .test:
            return URLs.testBaseUrl
        case .production:
            return URLs.productionBaseUrl
        }
    }
}
