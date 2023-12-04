//
//  UpdateInfoEntity.swift
//  zatex
//
//  Created by Zakirov Tahir on 09.07.2023.
//

import UIKit

struct UpdateInfoEntity {
    
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
    var email: String?
    var localAvatar: UIImage?
    var localBanner: UIImage?
    var isShop: Bool?
}
