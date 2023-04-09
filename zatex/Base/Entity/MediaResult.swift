//
//  MediaResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 09.04.2023.
//

import Foundation

struct MediaResult: Codable {
    
    struct MediaDetails: Codable {
        let sizes: MediaResult.Sizes?
    }
    
    struct Sizes: Codable {
        let woocommerceSingle: MediaResult.WoocommerceSingle?

        enum CodingKeys: String, CodingKey {
            case woocommerceSingle = "woocommerce_single"
        }
    }
    
    struct WoocommerceSingle: Codable {
        let sourceURL: String?

        enum CodingKeys: String, CodingKey {
            case sourceURL = "source_url"
        }
    }
    
    let id: Int?
    let mediaDetails: MediaResult.MediaDetails?

    enum CodingKeys: String, CodingKey {
        case id
        case mediaDetails = "media_details"
    }
}


