//
//  FavoritesAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 28.11.2023.
//

import Foundation

typealias FavoriteListClosure = (Result<[FavoriteResponse], NetworkError>) -> (Void)
typealias SetFavoriteClosure = (Result<(), NetworkError>) -> (Void)

protocol FavoritesAPI {
    
    func fetchFavoriteList(
        completion: @escaping FavoriteListClosure
    ) -> (Void)
    
    func addFavorite(
        productId: Int,
        completion: @escaping SetFavoriteClosure
    ) -> (Void)
    
    func removeFavorite(
        productId: Int,
        completion: @escaping SetFavoriteClosure
    ) -> (Void)
}
