//
//  SearchAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.10.2022.
//

import Foundation

typealias SearchClosure = ([ProductResult]) -> (Void)

protocol SearchAPI {
    func fetchSearchResult(search: String,
                           completion: @escaping SearchClosure) -> (Void)
}
