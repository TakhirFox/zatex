//
//  MapService.swift
//  zatex
//
//  Created by Zakirov Tahir on 04.04.2023.
//

import Alamofire

class MapService {
    private lazy var httpService = MapHttpService()
    static let shared: MapService = MapService()
}

extension MapService: MapAPI {
    
    func directGeocoding(
        address: String,
        completion: @escaping DirectMapClosure
    ) {
        do {
            try MapHttpRouter
                .directGeocoding(
                    address: address
                )
                .request(usingHttpService: httpService)
                .responseDecodable(of: [CoordinatesResult].self) { response in
                    if let responseData = response.data {
                        let text = String(data: responseData, encoding: .utf8)
                        print("LOG: TEXT 1: \(text ?? "---")")
                    }
                    
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 03463468767 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 37573734 Ошибка получения координатов для карт")))
        }
    }
    
    func reverseGeocoding(
        coordinates: CoordinareEntity,
        completion: @escaping ReverseMapClosure
    ) {
        do {
            try MapHttpRouter
                .reverseGeocoding(
                    coordinates: coordinates
                )
                .request(usingHttpService: httpService)
                .responseDecodable(of: AddressResult.self) { response in
                    if let responseData = response.data {
                        let text = String(data: responseData, encoding: .utf8)
                        print("LOG: TEXT 2: \(text ?? "---")")
                    }
                    
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 7834673467 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 756897 Ошибка получения адреса для карт")))
        }
    }
}
