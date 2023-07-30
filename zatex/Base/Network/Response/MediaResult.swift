//
//  MediaResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 09.04.2023.
//

import Foundation

struct MediaResult: Decodable {
    
    struct MediaDetails: Decodable {
        let sizes: MediaResult.Sizes?
    }
    
    struct Sizes: Decodable {
        let woocommerceSingle: MediaResult.WoocommerceSingle?

        enum CodingKeys: String, CodingKey {
            case woocommerceSingle = "woocommerce_single"
        }
    }
    
    struct WoocommerceSingle: Decodable {
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


