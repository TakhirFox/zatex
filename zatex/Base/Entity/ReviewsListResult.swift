//
//  ReviewsListResult.swift
//  zatex
//
//  Created by Zakirov Tahir on 20.03.2023.
//

import Foundation

struct ReviewsListResult: Decodable {
    
    struct Author: Decodable {
        let id: Int?
        let name: String?
        let avatar: String?
    }
    
    let id: Int?
    let author: ReviewsListResult.Author?
    let title, content, date: String?
    let rating: Int?
}


