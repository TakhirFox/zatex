//
//  StandConfiguration.swift
//  zatex
//
//  Created by Zakirov Tahir on 24.06.2024.
//

import Foundation

private enum Constant {
    static let infoKey = "Configuration"
}

enum StandConfiguration: String {
    case test
    case production
}

extension StandConfiguration {
    static var current: StandConfiguration {
        guard let savedConfiguration = UserDefaults.standard.standConfiguration else {
            switch Bundle.configuration {
            case .debug, .staging:
                return .test
            case .production:
                return .production
            }
        }
        
        return savedConfiguration
    }
}

enum Configuration: String {
    case debug
    case staging
    case production
}

extension Bundle {
    static var configuration: Configuration {
        guard let configurationValue = Bundle.main.object(forInfoDictionaryKey: Constant.infoKey) as? String,
              let configuration = Configuration(rawValue: configurationValue.lowercased()) else { return .production }
                
        return configuration
    }
}
