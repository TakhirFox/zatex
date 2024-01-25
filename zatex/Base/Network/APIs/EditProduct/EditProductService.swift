//
//  EditProductService.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.01.2024.
//

import Alamofire

class EditProductService {
    private lazy var httpService = EditProductHttpService()
    static let shared: EditProductService = EditProductService()
}

extension EditProductService: EditProductAPI {
    
    func fetchProductInfo(
        id: Int,
        completion: @escaping ProductClosure
    ) {
        do {
            try EditProductHttpRouter
                .getProductInfo(productId: id)
                .request(usingHttpService: httpService)
                .responseDecodable(of: ProductResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 346346346 - \(error)")))
                    }
                }
            
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 475457457 Ошибка получения товара")))
        }
    }
    
    func updateProductInfo(
        id: Int,
        product: ProductResponse,
        completion: @escaping UpdateProductClosure
    ) {
        do {
            try EditProductHttpRouter
                .updateProductInfo(
                    productId: id,
                    entity: product
                )
                .request(usingHttpService: httpService)
                .response { response in
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 3457435 - \(error)")))
                    }
                }
            
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 43576345734 Ошибка обновления товара")))
        }
    }
}
