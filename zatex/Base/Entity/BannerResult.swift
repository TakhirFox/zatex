//
//  BannerResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 24.10.2022.
//

import Foundation

struct BannerResult: Decodable, Hashable {
    let id: Int?
    let imageBanner: String?
    let firtsDesc, secondDesc, link: String?
}
