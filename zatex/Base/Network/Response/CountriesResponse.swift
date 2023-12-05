//
//  CountriesResponse.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.12.2023.
//

import Foundation

struct CountriesResponse: Codable {
    let id: Int
    let name: String
    let iso2: String?
}
