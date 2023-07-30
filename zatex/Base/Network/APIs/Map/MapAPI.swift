//
//  MapAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.04.2023.
//

import Foundation

typealias DirectMapClosure = (Result<[CoordinatesResult], NetworkError>) -> (Void)
typealias ReverseMapClosure = (Result<AddressResult, NetworkError>) -> (Void)

protocol MapAPI {
    
    func directGeocoding(
        address: String,
        completion: @escaping DirectMapClosure
    ) -> (Void)
    
    func reverseGeocoding(
        coordinates: CoordinareEntity,
        completion: @escaping ReverseMapClosure
    ) -> (Void)
}
