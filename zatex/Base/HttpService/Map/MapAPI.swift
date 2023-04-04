//
//  MapAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.04.2023.
//

import Foundation

typealias MapClosure = ([CoordinatesResult]) -> (Void)

protocol MapAPI {
    
    func fetchCoordinates(
        address: String,
        completion: @escaping MapClosure
    ) -> (Void)
}
