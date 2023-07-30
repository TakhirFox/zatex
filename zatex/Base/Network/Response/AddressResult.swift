//
//  AddressResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.07.2023.
//

import Foundation

struct AddressResult: Decodable {
    
    struct Address: Decodable {
        let houseNumber: String?
        let road: String?
        let city: String?
        let country: String?
        
        enum CodingKeys: String, CodingKey {
            case houseNumber = "house_number"
            case road, city, country
        }
    }
    
    let address: Address
}
