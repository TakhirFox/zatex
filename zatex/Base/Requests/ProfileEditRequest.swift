//
//  ProfileEditRequest.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.07.2023.
//

import Foundation

struct ProfileEditRequest: Encodable {
    
    struct Address: Codable {
        let street1: String?
        
        enum CodingKeys: String, CodingKey {
            case street1 = "street_1"
        }
    }
    
    let storeName: String?
    let firstName: String?
    let lastName: String?
    let phone: String?
    let address: Address?
    let banner: String?
    let bannerID: Int?
    let gravatar: String?
    let gravatarID: Int?
    let isShop: Bool?
    
    enum CodingKeys: String, CodingKey {
        case storeName = "store_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case phone
        case address
        case banner
        case bannerID = "banner_id"
        case gravatar
        case gravatarID = "gravatar_id"
        case isShop = "featured"
    }
}
