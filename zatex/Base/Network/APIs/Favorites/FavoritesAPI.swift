//
//  FavoritesAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.11.2023.
//

import Foundation

typealias FavoriteListClosure = (Result<[ProductResult], NetworkError>) -> (Void)
typealias SetFavoriteClosure = (Result<(), NetworkError>) -> (Void)

protocol FavoritesAPI {
    
    func fetchFavoriteList(
        userId: Int,
        completion: @escaping FavoriteListClosure
    ) -> (Void)
    
    func addFavorite(
        completion: @escaping SetFavoriteClosure
    ) -> (Void)
    
    func removeFavorite(
        completion: @escaping SetFavoriteClosure
    ) -> (Void)
}
