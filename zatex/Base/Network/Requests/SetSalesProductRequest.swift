//
//  SetSalesProductRequest.swift
//  zatex
//
//  Created by Zakirov Tahir on 06.08.2023.
//

import Foundation

struct SetSalesProductRequest: Encodable {
    let saleStatus: String
    
    enum CodingKeys: String, CodingKey {
        case saleStatus = "status"
    }
}
