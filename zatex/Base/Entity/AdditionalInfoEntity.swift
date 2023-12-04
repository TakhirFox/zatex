//
//  AdditionalInfoEntity.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.07.2023.
//

import UIKit

struct AdditionalInfoEntity {
    
    struct Address {
        var street: String?
        var city: String?
        var country: String?
    }
    
    var storeName: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
    var address: Address?
    var avatar: UIImage?
    var banner: UIImage?
    var isShop: Bool?
}
