//
//  ReviewEntity.swift
//  zatex
//
//  Created by Zakirov Tahir on 29.04.2023.
//

struct ReviewEntity: Encodable {
    let title: String
    let content: String?
    let rating: Int
}
