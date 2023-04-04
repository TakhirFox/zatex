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
    
    func fetchCoordinates(
        address: String,
        completion: @escaping MapClosure
    ) {
        do {
            try MapHttpRouter
                .coordinates(
                    address: address
                )
                .request(usingHttpService: httpService)
                .responseDecodable(of: [CoordinatesResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 03463468767: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 37573734: Ошибка получения координатов для карт")
        }
    }
}
