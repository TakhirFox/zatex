//
//  UserDefaults+standConfiguration.swift
//  zatex
//
//  Created by Zakirov Tahir on 24.06.2024.
//

import Foundation

private struct Constant {
    static var key = "currentStand"
}

extension UserDefaults {
    var standConfiguration: StandConfiguration? {
        get {
            guard let rawValue = self.string(forKey: Constant.key), let configuration = StandConfiguration(rawValue: rawValue) else {
               return nil
            }
            
            return configuration
        }
        
        set {
            self.set(newValue?.rawValue, forKey: Constant.key)
        }
    }
}
