//
//  NewsAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 29.11.2023.
//

import Foundation

typealias NewsListClosure = (Result<[BannerResult], NetworkError>) -> (Void)

protocol NewsAPI {
    
    func fetchNewsList(
        completion: @escaping NewsListClosure
    ) -> (Void)
}
