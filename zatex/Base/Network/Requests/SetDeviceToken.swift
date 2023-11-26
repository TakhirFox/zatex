//
//  SetDeviceToken.swift
//  zatex
//
//  Created by Zakirov Tahir on 26.11.2023.
//

import Foundation

struct SetDeviceToken: Encodable {
    
    let deviceToken: String
    
    enum CodingKeys: String, CodingKey {
        case deviceToken = "device-token"
    }
}
